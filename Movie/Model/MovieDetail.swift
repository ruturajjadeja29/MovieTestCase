//
//  MovieDetail.swift
//  Movie
//
//  Created by mac-0008 on 05/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation

struct MovieDetail {
    
    var adult: Bool?
    var backdrop_path: String?
    var belongs_to_collection: Bool?
    var budget: Double?
    var genres: Any?
    var homepage: String?
    var id: Int64?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var production_companies: Any?
    var production_countries: Any?
    var release_date: String?
    var revenue: Double?
    var runtime: Double?
    var spoken_languages: Any?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int64?
    
    init(dict: [String:Any]) {
    }
}
