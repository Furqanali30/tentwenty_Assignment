//
//  MovieClass.swift
//  tentwenty
//
//  Created by Furqan Ali Khan on 01/04/2022.
//

import Foundation

import UIKit

class MovieClass {

    var id: String?
    var title: String?
    var poster_path: String?
    var overview: String?
    var templateType:Int? //1 = Movies , 2 = Categories, 3 = Search
    
    
    required init?() {
        id = ""
        title = ""
        poster_path = ""
        overview = ""
        templateType = 0
        
    }
    
    init(templateTye:Int){
        id = ""
        title = ""
        poster_path = ""
        overview = ""
        self.templateType = templateTye
    }
    
}
