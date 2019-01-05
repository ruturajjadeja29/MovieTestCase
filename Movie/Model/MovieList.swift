//
//  MovieList.swift
//  Movie
//
//  Created by mac-0009 on 05/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation

struct MovieList {
    
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: Any?
    var id: Int64?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int64?
    
    init(dict: [String:Any]) {
        
        let json = JSON(dict)
        
        if json["adult"].error != .notExist {
            self.adult = json["adult"].boolValue
        }
        
        if json["backdrop_path"].error != .notExist {
            self.backdrop_path = json["backdrop_path"].stringValue
        }
        
        if json["genre_ids"].error != .notExist {
            self.genre_ids = json["genre_ids"]
        }
        
        if json["id"].error != .notExist {
            self.id = json["id"].int64Value
        }
        
        if json["original_language"].error != .notExist {
            self.original_language = json["original_language"].stringValue
        }
        
        if json["original_title"].error != .notExist {
            self.original_title = json["original_title"].stringValue
        }
        
        if json["overview"].error != .notExist {
            self.overview = json["overview"].stringValue
        }
        
        if json["popularity"].error != .notExist {
            self.popularity = json["popularity"].doubleValue
        }
        
        if json["poster_path"].error != .notExist {
            self.poster_path = json["poster_path"].stringValue
        }
        
        if json["release_date"].error != .notExist {
            self.release_date = json["release_date"].stringValue
        }
        
        if json["title"].error != .notExist {
            self.title = json["title"].stringValue
        }
        
        if json["video"].error != .notExist {
            self.video = json["video"].boolValue
        }
        
        if json["vote_average"].error != .notExist {
            self.vote_average = json["vote_average"].doubleValue
        }
        
        if json["vote_count"].error != .notExist {
            self.vote_count = json["vote_count"].int64Value
        }
        
    }
    
}
