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

class MovieListVC: ParentVC {
    
    // MARK: -
    // MARK: - @IBOutlets.
    @IBOutlet fileprivate weak var tblVMovieList: UITableView!
    @IBOutlet fileprivate weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    // MARK: -
    // MARK: - Global Variables.
    fileprivate let disposeBag = DisposeBag()
    
    
    // MARK: -
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

}

extension MovieListVC {
    
    fileprivate func initialize() {
        //...Load Data
        MovieViewModel.shared.loadMoviesFromServer()
        
        //...Manage Observer and Subscriber
        manageObserverAndSubscriber()
    }
    
    fileprivate func manageObserverAndSubscriber() {
        //...Observing isAPIRunning property for activityIndicator.
        MovieViewModel.shared.isAPIRunning.asObservable().subscribe(onNext: { (isLoading) in
            if !isLoading {
                let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Movie.entityName)
                do {
                    if let count = try CAppdelegate?.persistentContainer.viewContext.count(for: fetchRequest), count > 0 {
                        self.tblVMovieList.isHidden = false
                        self.activityIndicatorView.stopAnimating()
                    }
                } catch {
                    
                }
            }
        }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
        
        
        //...List(UITableView) DataSource.
        let animatedDataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, Movie>>(configureCell: { dateSource, tableView, indexPath, movie in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListTblCell
            cell.configureCell(movie: movie)
            return cell
        })
        
        
        //...Creates and executes a fetch request and returns the fetched objects as an Observable array of Persistable.
        CAppdelegate?.persistentContainer.viewContext.rx.entities(Movie.self, sortDescriptors: [NSSortDescriptor(key: "id", ascending: false)]).map { movieList in
                [AnimatableSectionModel(model: "", items: movieList)]
            }.bind(to: tblVMovieList.rx.items(dataSource: animatedDataSource)).disposed(by: disposeBag)
        
        
        
        //...Observing UITableView row selection.
        Observable.zip(tblVMovieList.rx.itemSelected, tblVMovieList.rx.modelSelected(Movie.self)).bind { indexPath, movieModel in
            if let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailVC {
                movieDetailVC.movieModel = movieModel
                self.navigationController?.pushViewController(movieDetailVC, animated: true)
            }
        }.disposed(by: disposeBag)
        
    }
    
}
