//
//  MoviesViewModel.swift
//  tentwenty
//
//  Created by Furqan Ali Khan on 01/04/2022.
//

import Foundation
import SwiftyJSON

class MoviesViewModel {

    var dataList = [MovieClass]()
    var searchResultArray = [MovieClass]()
    
    required init?() {
    
    }
    
    
    func getmatchesListingServiceRequestResponse(inputObject:ServiceResponseClass)
    {
        dataList.removeAll()
        let result:JSON = inputObject.json!

        for (_,subJson):(String, JSON) in result["results"] {
            let tempObj = MovieClass()
            tempObj?.id = subJson["id"].string ?? ""
            tempObj?.title = subJson["title"].string ?? ""
            tempObj?.poster_path = subJson["backdrop_path"].string ?? ""
            tempObj?.poster_path =  "https://image.tmdb.org/t/p/w500"  + (tempObj?.poster_path)!
            tempObj?.templateType = 1
            dataList.append(tempObj!)
        }
       
    }
    
    
    
    func showTemplate3(){
        self.dataList.forEach { current in
            current.templateType = 3
        }
       
    }
    func showTemplate2(){
        self.dataList.forEach { current in
            current.templateType = 2
        }
 
    }
    
    func showTemplate1(){
        self.dataList.forEach { current in
            current.templateType = 1
        }
    }
    
    
    func searchInTheData(inputString:String) -> [MovieClass]
    {
        searchResultArray.removeAll()
        self.dataList.forEach { current in
            if current.title?.lowercased().contains(inputString) == true{
                current.templateType = 3
                self.searchResultArray.append(current)
            }
        }
       return searchResultArray
    }
    
    
}
