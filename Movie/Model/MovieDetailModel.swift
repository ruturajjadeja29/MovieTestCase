//
//  MovieDetailModel.swift
//  Movie
//
//  Created by mac-0008 on 07/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieDetailModel : Mappable  {
    
    var title:String?
    var contents:Any?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        contents <- map["contents"]
    }
}

struct MovieHeaderModel: Mappable {
    
    var backdrop_path:String?
    var poster_path:String?
    var title:String?
    var tagline:String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        backdrop_path <- map["backdrop_path"]
        poster_path <- map["poster_path"]
        title <- map["title"]
        tagline <- map["tagline"]
    }
}




