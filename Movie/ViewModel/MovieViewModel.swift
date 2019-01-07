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
    var movies: Variable<[[String:Any]]> = Variable([])
    var isAPIRunning: Variable<Bool> = Variable(true)
}


// MARK: -
// MARK: - Load data from server.
extension MovieViewModel {
    
    func loadMoviesFromServer() {
        APIRequest.shared.movies(successCompletion: { (response, status) in
            
            if let resultDict = response as? [String:Any],
                let arrResult = resultDict["results"] as? [[String:Any]], arrResult.count > 0 {
                
                for json in arrResult {
                    try? CAppdelegate?.persistentContainer.viewContext.rx.update(Movie(object: json))
                }
                
                self.movies.value = arrResult
                self.isAPIRunning.value = false
            }
            
        }, failureCompletion: { (message) in
            self.isAPIRunning.value = false
        })
    }
    
}
