//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by mac-0008 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailViewModel {
    
    // MARK: -
    // MARK: - Singleton.
    private init() {}
    
    private static var movieDetailViewModel: MovieDetailViewModel = {
        let movieDetailViewModel = MovieDetailViewModel()
        return movieDetailViewModel
    }()
    
    static var shared: MovieDetailViewModel {
        return movieDetailViewModel
    }
    
    // MARK: -
    // MARK: - Rx-Swift Observable.
    var movieDetail:Variable<TBLMovieDetail>?
}

// MARK: -
// MARK: - General Methods.
extension MovieDetailViewModel {
    
    func loadMovieDetails() {
        
    }
}
