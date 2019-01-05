//
//  MovieListModel.swift
//  Movie
//
//  Created by mac-0009 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String:Any]

class MovieListModel {
    
    var id: String
    var moviePoster: String?
    var movieTitle: String?
    var movieReleaseDate: String?
    var movieOverview: String?
    
    init?(dict: JSONDictionary) {
        
        guard let id = dict["id"] as? String, let moviePoster = dict["id"] as? String, let movieTitle = dict["name"] as? String, let movieReleaseDate = dict["description"] as? String, let movieOverview = dict["description"] as? String else {
                return nil
        }
        
        self.id = id
        self.moviePoster = moviePoster
        self.movieTitle = movieTitle
        self.movieReleaseDate = movieReleaseDate
        self.movieOverview = movieOverview
        
    }
    
}
