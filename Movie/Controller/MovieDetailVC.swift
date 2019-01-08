//
//  MovieDetailVC.swift
//  Movie
//
//  Created by mac-0008 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxCoreData
import RxDataSources
import CoreData

class MovieDetailVC: ParentVC {
    
    // MARK: -
    // MARK: - @IBOutlets.
    @IBOutlet fileprivate weak var scrollVDetail: UIScrollView!
    @IBOutlet fileprivate weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet fileprivate weak var imgVPoster: UIImageView!
    @IBOutlet fileprivate weak var imgVCoverPoster: UIImageView!
    @IBOutlet fileprivate weak var lblMovieTitle: UILabel!
    @IBOutlet fileprivate weak var lblMovieTagline: UILabel!
    
    @IBOutlet fileprivate weak var lblOverview: UILabel!
    @IBOutlet fileprivate weak var lblGenres: UILabel!
    @IBOutlet fileprivate weak var lblDuration: UILabel!
    @IBOutlet fileprivate weak var lblReleaseDate: UILabel!
    @IBOutlet fileprivate weak var lblProductionCompanies: UILabel!
    @IBOutlet fileprivate weak var lblProductionBudget: UILabel!
    @IBOutlet fileprivate weak var lblRevenue: UILabel!
    @IBOutlet fileprivate weak var lblLanguages: UILabel!

    
    // MARK: -
    // MARK: - Global Variables.
    var movieModel : Movie?
    let disposeBag = DisposeBag()
    
    
    // MARK: -
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
}

// MARK: -
// MARK: - General Methods.
extension MovieDetailVC {
    
    func initialize() {
        if let movieModel = movieModel {
            //...Load Data
            MovieViewModel.shared.loadMovieDetailFromServer(byId: movieModel.id ?? 0)
            
            //...Manage Observer and Subscriber
            manageObserverAndSubscriber()
        }
    }
    
    fileprivate func manageObserverAndSubscriber() {
        
        //...Observing isAPIRunning property for activityIndicator.
        MovieViewModel.shared.isAPIRunning.asObservable().subscribe(onNext: { (isLoading) in
            if !isLoading {
                self.scrollVDetail.isHidden = false
                self.activityIndicatorView.stopAnimating()
            }
        }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
        
        
        //...Create and execute a fetch request and return the fetched movie detail object as an Observable array of Persistable.
        CAppdelegate?.persistentContainer.viewContext.rx.entities(Movie.self, predicate: NSPredicate(format: "id == %d", (movieModel?.id ?? 0))).asObservable().subscribe(onNext: { (movies) in
            
            if let movie = movies.last {
                self.title = movie.title
                
                self.imgVCoverPoster.kf.setImage(with: (ApplicationConstants.imageBaseURL + (movie.backdropPath ?? "")).toURL)
                self.imgVPoster.kf.setImage(with: (ApplicationConstants.imageBaseURL + (movie.posterPath ?? "")).toURL)
                self.lblMovieTitle.text = movie.title
                self.lblMovieTagline.text = movie.tagline
                
                self.lblOverview.text = movie.overview
                self.lblGenres.text = MovieViewModel.shared.getAllGenresByNameOfMovie(movie)
                
                let duration = movie.runtime ?? 0
                self.lblDuration.text = "\(duration) \((duration == 1 ? "Minute" : "Minutes"))"
                
                self.lblReleaseDate.text = movie.releaseDate
                self.lblProductionCompanies.text = MovieViewModel.shared.getAllProductionCompaniesByNameOfMovie(movie)
                self.lblProductionBudget.text = "$\(movie.budget ?? 0)"
                self.lblRevenue.text = "$\(movie.revenue ?? 0)"
                self.lblLanguages.text = MovieViewModel.shared.getAllLanguagesByNameOfMovie(movie)
            }
            
        }).disposed(by: disposeBag)
    }
}
