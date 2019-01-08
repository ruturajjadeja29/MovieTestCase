//
//  MovieListVC.swift
//  Movie
//
//  Created by mac-0009 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxCoreData
import RxDataSources
import CoreData

class MovieListVC: UIViewController {

    // MARK: -
    // MARK: - @IBOutlets.
    
    @IBOutlet fileprivate weak var tblVMovieList: UITableView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    // MARK: -
    // MARK: - Global Variables.
    
    let disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: - View Controllers Lifecycle.
    
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

extension MovieListVC {
    
    fileprivate func initialize() {
        configureViewAppearance()
    }
    
    fileprivate func configureViewAppearance() {
        MovieViewModel.shared.loadMovieListFromServer()
        manageObserverAndSubscriber()
    }
    
    fileprivate func manageObserverAndSubscriber() {
        
        //... Observe isAPIRunning property for activityIndicator.
        
        MovieViewModel.shared.isAPIRunning.asObservable().subscribe(onNext: { (isLoading) in
            
            if TBLMovie.allObjects?.count ?? 0 > 0 {
                self.activityLoader.stopAnimating()
            }
            
        }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
        
        //... Configure DataSource.
        
        let animatedDataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, Movie>>(configureCell: { dateSource, tableView, indexPath, movie in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListTblCell
            cell.configureCell(movie: movie)
            return cell
            
        })
        
        //... Creates and executes a fetch request and returns the fetched objects as an Observable array of Persistable.
        
        CAppdelegate?.persistentContainer.viewContext.rx.entities(Movie.self, sortDescriptors: [NSSortDescriptor(key: "id", ascending: false)]).map { movieList in
                [AnimatableSectionModel(model: "", items: movieList)]
            }.bind(to: tblVMovieList.rx.items(dataSource: animatedDataSource)).disposed(by: disposeBag)
        
        Observable.zip(tblVMovieList.rx.itemSelected, tblVMovieList.rx.modelSelected(Movie.self)).bind { indexPath, movieModel in
            
            if let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailVC {
                movieDetailVC.movieModel = movieModel
                self.navigationController?.pushViewController(movieDetailVC, animated: true)
            }
            
            }.disposed(by: disposeBag)
        
    }
    
}
