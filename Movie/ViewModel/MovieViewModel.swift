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
    
    private static var movieViewModel: MovieViewModel = {
        return MovieViewModel()
    }()
    
    static var shared: MovieViewModel {
        return movieViewModel
    }
    
    
    // MARK: -
    // MARK: - Rx-Swift Observable.
    var isAPIRunning: Variable<Bool> = Variable(true)
}


// MARK: -
// MARK: - Load data from server.
extension MovieViewModel {
    
    func loadMoviesFromServer() {
        self.isAPIRunning.value = true
        
        APIRequest.shared.movies(successCompletion: { (response, status) in
            if let resultDict = response as? [String:Any],
                let arrResult = resultDict["results"] as? [[String:Any]], arrResult.count > 0 {
                
                for json in arrResult {
                    try? CAppdelegate?.persistentContainer.viewContext.rx.update(Movie(object: json))
                }
                self.isAPIRunning.value = false
            }
            
        }, failureCompletion: nil)
    }
    
    func loadMovieDetailFromServer(byId id: Int64) {
        self.isAPIRunning.value = true
        
        APIRequest.shared.movieDetails(movieID: id, successCompletion: { (response, status) in
            if let responseDict = response as? [String: Any] {
                try? CAppdelegate?.persistentContainer.viewContext.rx.update(Movie(object: responseDict))
            }
            self.isAPIRunning.value = false
        }, failureCompletion: { (message) in
            
        })
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

