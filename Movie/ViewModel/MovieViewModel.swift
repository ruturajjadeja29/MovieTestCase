//
//  MovieViewModel.swift
//  Movie
//
//  Created by mac-0009 on 07/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation
import RxSwift

class MovieViewModel {
    
    // MARK: -
    // MARK: - Singleton.
    
    private init() {}
    
    private static var movieViewModel:MovieViewModel = {
        return MovieViewModel()
    }()
    
    static var shared:MovieViewModel {
        return movieViewModel
    }
    
    
    
    // MARK: -
    // MARK: - Rx-Swift Observable.
    
    var movies:Variable<[[String:Any]]> = Variable([])
    var isAPIRunning:Variable<Bool> = Variable(true)
    
    
    
}

extension MovieViewModel {
    
    func loadMovieListFromServer() {
        
        APIRequest.shared.movies(successCompletion: { (response, status) in
            
            if let resultDict = response as? [String:Any], let arrResult = resultDict["results"] as? [[String:Any]], arrResult.count > 0
            {
                for json in arrResult {
                    
                    let adult = json["adult"] as? Bool ?? false
                    let backdrop_path = json["backdrop_path"] as? String ?? ""
                    let genre_ids = json["genre_ids"] ?? []
                    let id = json["id"] as? Int64 ?? 0
                    let original_language = json["original_language"] as? String ?? ""
                    let original_title = json["original_title"] as? String ?? ""
                    let overview = json["overview"] as? String ?? ""
                    
                    let popularity = json["popularity"] as? Double ?? 0
                    let poster_path = json["poster_path"] as? String ?? ""
                    let release_date = json["release_date"] as? String ?? ""
                    let title = json["title"] as? String ?? ""
                    let video = json["video"] as? Bool ?? false
                    let vote_average = json["vote_average"] as? Double ?? 0
                    let vote_count = json["vote_count"] as? Int64 ?? 0
                    
                    try? CAppdelegate?.persistentContainer.viewContext.rx.update(Movie(object: json))
                    
                    //                    try? CAppdelegate?.persistentContainer.viewContext.rx.update(MovieListModel(adult: adult,
                    //                                                                       backdrop_path: backdrop_path,
                    //                                                                       genre_ids: genre_ids,
                    //                                                                       id: id,
                    //                                                                       original_language: original_language,
                    //                                                                       original_title: original_title,
                    //                                                                       overview: overview,
                    //                                                                       popularity: popularity,
                    //                                                                       poster_path: poster_path,
                    //                                                                       release_date: release_date,
                    //                                                                       title: title,
                    //                                                                       video: video,
                    //                                                                       vote_average: vote_average,
                    //                                                                       vote_count: vote_count))
                    
                }
                self.movies.value = arrResult
                self.isAPIRunning.value = false
                
            }
            
        }, failureCompletion: { (message) in
            self.isAPIRunning.value = false
        })
        
    }
    
    func loadDetailForMovie(id: Int64) {
        _ = APIRequest.shared.movieDetails(movieID: id, successCompletion: { (response, status) in
            
            if let responseDict = response as? [String: Any] {
                
                try? CAppdelegate?.persistentContainer.viewContext.rx.update(Movie(object: responseDict))
                
            }
        }, failureCompletion: nil)
    }
    
    func getAllGenresByNameOfMovie(_ movie: Movie) -> String {
        return movie.genres?.compactMap({$0.name}).joined(separator: ", ") ?? ""
    }
    
    func getAllProductionCompaniesByNameOfMovie(_ movie: Movie) -> String {
        return movie.productionCompanies?.compactMap({$0.name}).joined(separator: ", ") ?? ""
    }
    
    func getAllLanguagesByNameOfMovie(_ movie: Movie) -> String {
        return movie.spokenLanguages?.compactMap({$0.name}).joined(separator: ", ") ?? ""
    }
    
}
