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

class MovieListVC: UIViewController {

    // MARK: -
    // MARK: - @IBOutlets.
    
    @IBOutlet fileprivate weak var tblVMovieList: UITableView! 
    
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
    }

}

extension MovieListVC {
    
    fileprivate func initialize() {
        configureViewAppearance()
    }
    
    fileprivate func configureViewAppearance() {
        manageObserverAndSubscriber()
    }
    
    fileprivate func manageObserverAndSubscriber() {
        
        //... SUBSRIBE OBSERVERABLE
        
        MovieListViewModel.shared.movies.asObservable().subscribe(onNext: { (movies) in
            print(movies)
            
        }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
        
        //... BIND OBSERVERABLE
        
        MovieListViewModel.shared.movies.asObservable().bind(to: tblVMovieList.rx.items(cellIdentifier: "MovieListCell", cellType: MovieListTblCell.self)) { (row, movies, cell) in
            cell.configureCell(movie: movies)
        }.disposed(by: disposeBag)

    }
    
}
