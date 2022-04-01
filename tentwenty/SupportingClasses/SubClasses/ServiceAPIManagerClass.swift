//
//  ServiceAPIManagerClass.swift
//  pickVault
//
//  Created by Furqan Ali Khan on 22/07/2020.
//  Copyright © 2020 Furqan Ali Khan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ServiceAPIManagerClass: NSObject {
    
    static let shared = ServiceAPIManagerClass()
    
    static func getSingletonObject () -> ServiceAPIManagerClass {
        return shared
    }
    
    
    func MakeServiceCall2(url: String,type: String,parameters:[String: Any]? ,onSuccess: @escaping(ServiceResponseClass) -> Void, onFailure: @escaping(ServiceResponseClass) -> Void){
        
        if InternetConnectivityClass.isConnectedToNetwork()
        {
            let type:HTTPMethod = type == "POST" ? .post : .get
            
            AF.sessionConfiguration.timeoutIntervalForRequest = 15
            AF.request(url,method: type, parameters: parameters).responseData{ response in
                debugPrint(response)
                let result = ServiceResponseClass()
                
                let error = response.error
                if(error != nil)
                {
                    print("Service Returned Error Furqan, =   \(error.debugDescription)")
                    result?.json = nil
                    result?.responseCode = 0
                    result?.error = error as NSError?
                    result?.errorMessage = UserDataClass.getSingletonObject().serverError
                    onFailure(result!)
                }
                
                switch response.result {
                case .success:
                    
                    print("Service Returned Successfully")
                    var statusCode:Int = 0
                    do
                    {
//                        statusCode = response.response?.statusCode ?? 0 //using service returned code rather than HTTP CODE
                        
                        let data = try JSON(data: response.data!)
                        statusCode = data["code"].int ?? 0
                        
                        result?.json = data
                        result?.responseCode = statusCode
                        result?.error = nil
                        result?.errorMessage = data["message"].string ?? "" // Incase if service is returning any error  in specific code
                        onSuccess(result!)
                    }
                    catch let error as NSError
                    {
                        print("Error ",error)
                        
                        result?.json = nil
                        result?.responseCode = statusCode
                        result?.error = error as NSError?
                        result?.errorMessage = UserDataClass.getSingletonObject().tryCatchError
                        //404 is error when my URL is invalid not When server is not coming.
                        //if statusCode == 404
                        //{
                        //result?.errorMessage = UserDataClass.getSingletonObject().serverError
                        //}
                        onFailure(result!)
                    }
                    
                    
                case let .failure(error):
                    print("Service Returned Error, =   \(error)")
                    result?.json = nil
                    result?.responseCode = 0
                    result?.error = error as NSError?
                    result?.errorMessage = UserDataClass.getSingletonObject().serverError
                    onFailure(result!)
                }
            }
            
        }
        else
        {
            let result = ServiceResponseClass()
            result?.json = nil
            result?.responseCode = 0
            result?.error = nil
            result?.errorMessage = UserDataClass.getSingletonObject().noInternetError
            onFailure(result!)
        }
    }
    
    
}
class ServiceResponseClass {
    var json : JSON?
    var responseCode : Int?
    var errorMessage : String?
    var error : NSError?
    
    required init?() {
        //           json = nil
        responseCode = 0
        errorMessage = ""
        
    }
}

