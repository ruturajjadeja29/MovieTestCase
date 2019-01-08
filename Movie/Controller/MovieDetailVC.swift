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

class MovieDetailVC: UIViewController {
    
    // MARK: -
    // MARK: - @IBOutlets.
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
    let imgHeaderUrl = "https://image.tmdb.org/t/p/w500"
    
    
    // MARK: -
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = CRGB(r: 41, g: 51, b: 71)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

// MARK: -
// MARK: - General Methods.
extension MovieDetailVC {
    
    func initialize() {
        if let movieModel = movieModel {
            MovieViewModel.shared.loadDetailForMovie(id: movieModel.id ?? 0)
            self.configureViewAppearance()
        }
        
    }
    
    fileprivate func configureViewAppearance() {
        addObserverAndSubscriber()
    }
    
    fileprivate func configureHeader(movie: Movie) {
        
        self.lblMovieTitle.text = movie.title ?? ""
        self.lblMovieTagline.text = movie.tagline ?? ""
        self.title = movie.title ?? ""
        
        if let urlBackDropPoster = movie.backdropPath {
            imgVCoverPoster.kf.setImage(with: (imgHeaderUrl + urlBackDropPoster).toURL)
        }
        
        if let urlPoster = movie.posterPath {
            imgVPoster.kf.setImage(with: (imgHeaderUrl + urlPoster).toURL)
        }
    }
    
    fileprivate func addObserverAndSubscriber() {
        
        MovieViewModel.shared.isAPIRunning.asObservable().subscribe(onNext: { (isLoading) in
            
            if TBLMovie.allObjects?.count ?? 0 > 0 {
//                self.activityLoader.stopAnimating()
            }
            
        }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
        
        //... Configure DataSource.
        
        
        //... Creates and executes a fetch request and returns the fetched objects as an Observable array of Persistable.
        
        CAppdelegate?.persistentContainer.viewContext.rx.entities(Movie.self, predicate: NSPredicate(format: "id == %d", (movieModel?.id ?? 0))).asObservable().subscribe(onNext: { (movies) in
            
            if let movie = movies.last {
                self.title = movie.title
                
                self.imgVCoverPoster.kf.setImage(with: (imgBaseURL + (movie.backdropPath ?? "")).toURL)
                self.imgVPoster.kf.setImage(with: (imgBaseURL + (movie.posterPath ?? "")).toURL)
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
