//
//  MovieListViewModel.swift
//  Movie
//
//  Created by mac-0009 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation
import RxSwift

class MovieListViewModel {
    
    // MARK: -
    // MARK: - Singleton.
    
    private init() {}
    
    private static var movieListViewModel:MovieListViewModel = {
        let movieListViewModel = MovieListViewModel()
        return movieListViewModel
    }()
    
    static var shared:MovieListViewModel {
        return movieListViewModel
    }
    
    
    
    // MARK: -
    // MARK: - Rx-Swift Observable.
    
    var movies:Variable<[TBLMovieList]> = Variable([])
    
}
