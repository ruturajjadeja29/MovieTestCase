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
    
    // MARK: -
    // MARK: - Global Variables.
    var managedObjectContext: NSManagedObjectContext!
    let disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: - View Controllers Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension MovieListVC {
    
    fileprivate func initialize() {
        managedObjectContext = CoreDataManager.shared.managedObject()
        configureViewAppearance()
    }
    
    fileprivate func configureViewAppearance() {
        loadMovieListFromServer()
        manageObserverAndSubscriber()
    }
    
    fileprivate func loadMovieListFromServer() {
        
        APIRequest.shared.movies(successCompletion: { (response, status) in
            
            if let resultDict = response as? [String:Any], let arrResult = resultDict["results"] as? [[String:Any]], arrResult.count > 0 {
                
                for item in arrResult {
                    try? self.managedObjectContext.rx.update(MovieList(dict: item))
                }
            }
            
        }, failureCompletion: { (message) in
            
        })
        
    }
    
    fileprivate func manageObserverAndSubscriber() {
        
        //... SUBSRIBE OBSERVERABLE
        
//        MovieListViewModel.shared.movies.asObservable().subscribe(onNext: { (movies) in
//            print(movies)
//
//        }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
        
        //... BIND OBSERVERABLE
        
//        MovieListViewModel.shared.movies.asObservable().bind(to: tblVMovieList.rx.items(cellIdentifier: "MovieListCell", cellType: MovieListTblCell.self)) { (row, movies, cell) in
//            cell.configureCell(movie: movies)
//        }.disposed(by: disposeBag)
        
        let animatedDataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, MovieList>>(configureCell: { dateSource, tableView, indexPath, event in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//            cell.textLabel?.text = "\(event.date)"
            return cell
        })
        
        managedObjectContext.rx.entities(MovieList.self,   sortDescriptors: [NSSortDescriptor(key: "id", ascending: false)])
            .map { movieList in
                [AnimatableSectionModel(model: "", items: movieList)]
            }
            .bind(to: tblVMovieList.rx.items(dataSource: animatedDataSource))
            .disposed(by: disposeBag)
        
        

    }
    
}
