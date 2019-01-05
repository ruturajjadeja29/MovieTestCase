//
//  MovieList+Extensions.swift
//  Movie
//
//  Created by mac-0009 on 05/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData

func == (lhs: MovieList, rhs: MovieList) -> Bool {
    return lhs.id == rhs.id
}

extension MovieList : Equatable { }

extension MovieList : IdentifiableType {
    typealias Identity = String
    
    var identity: Identity { return "\(id ?? 0)" }
}

extension MovieList : Persistable
{
    
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "TBLMovieList"
    }
    
    static var primaryAttributeName: String {
        return "id"
    }
    
    init(entity: T) {
        
        adult               = entity.value(forKey: "adult") as! Bool
        backdrop_path       = entity.value(forKey: "backdrop_path") as? String
        genre_ids           = entity.value(forKey: "genre_ids") as Any
        id                  = entity.value(forKey: "id") as! Int64
        original_language   = entity.value(forKey: "original_language") as! String
        original_title      = entity.value(forKey: "original_title") as! String
        overview            = entity.value(forKey: "overview") as! String
        popularity          = entity.value(forKey: "popularity") as! Double
        poster_path         = entity.value(forKey: "poster_path") as! String
        release_date        = entity.value(forKey: "release_date") as! String
        title               = entity.value(forKey: "title") as! String
        video               = entity.value(forKey: "video") as! Bool
        vote_average        = entity.value(forKey: "vote_average") as! Double
        vote_count          = entity.value(forKey: "vote_count") as! Int64
        
    }
    
    func update(_ entity: T) {
        
        entity.setValue(adult, forKey: "adult")
        entity.setValue(backdrop_path, forKey: "backdrop_path")
        entity.setValue(genre_ids, forKey: "genre_ids")
        entity.setValue(id, forKey: "id")
        entity.setValue(original_language, forKey: "original_language")
        entity.setValue(original_title, forKey: "original_title")
        entity.setValue(overview, forKey: "overview")
        entity.setValue(popularity, forKey: "popularity")
        entity.setValue(poster_path, forKey: "poster_path")
        entity.setValue(release_date, forKey: "release_date")
        entity.setValue(title, forKey: "title")
        entity.setValue(video, forKey: "video")
        entity.setValue(vote_average, forKey: "vote_average")
        entity.setValue(vote_count, forKey: "vote_count")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
        
    }
    
}

