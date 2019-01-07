//
//  MovieDetailVC.swift
//  Movie
//
//  Created by mac-0008 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit
import RxSwift

class MovieDetailVC: UIViewController {
    
    // MARK: -
    // MARK: - @IBOutlets.
    @IBOutlet fileprivate weak var imgVPoster: UIImageView!
    @IBOutlet fileprivate weak var imgVCoverPoster: UIImageView!
    @IBOutlet fileprivate weak var lblMovieTitle: UILabel!
    @IBOutlet fileprivate weak var lblMovieTagline: UILabel!
    
    @IBOutlet fileprivate weak var tblVMovieDetail: UITableView! {
        didSet {
            tblVMovieDetail.estimatedRowHeight = 100.0
            tblVMovieDetail.rowHeight = UITableView.automaticDimension
        }
    }
    
    @IBOutlet fileprivate weak var viewHeader: UIView! {
        didSet {
            viewHeader.CViewSetHeight(height: (CScreenWidth/375) * viewHeader.frame.height)
        }
    }
    
    // MARK: -
    // MARK: - Global Variables.
    let disposeBag = DisposeBag()
    let imgHeaderUrl = "https://image.tmdb.org/t/p/w500"
    
    // MARK: -
    // MARK: - View Lifecycle.
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
        
        MovieDetailViewModel.shared.loadMovieDetailsFromServer()
        
        self.configureViewAppearance()
    }
    
    fileprivate func configureViewAppearance() {
        addObserverAndSubscriber()
    }
    
    fileprivate func configureHeader(movieHeader: MovieHeaderModel) {
        
        self.lblMovieTitle.text = movieHeader.title ?? ""
        self.lblMovieTagline.text = movieHeader.tagline ?? ""
        self.title = movieHeader.title ?? ""
        
        if let urlBackDropPoster = movieHeader.backdrop_path {
            imgVCoverPoster.kf.setImage(with: (imgHeaderUrl + urlBackDropPoster).toURL)
        }
        
        if let urlPoster = movieHeader.poster_path {
            imgVPoster.kf.setImage(with: (imgHeaderUrl + urlPoster).toURL)
        }
    }
    
    fileprivate func addObserverAndSubscriber() {
        
        //... Keep Observing for movieHeader Updates and Bind the Data.
        MovieDetailViewModel.shared.movieHeader.asObservable().subscribe(onNext: { (movieHeader) in
            self.configureHeader(movieHeader: movieHeader)
        }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
        
        //.. Keep Observing for movieDetails Updates and Bind the Data.
        MovieDetailViewModel.shared.arrDetailCustom.asObservable().bind(to: tblVMovieDetail.rx.items(cellIdentifier: "MovieDetailTblCell", cellType:MovieDetailTblCell.self)) { (row, movieDetails, cell) in
            cell.configureCell(movieDetails: movieDetails)
            }.disposed(by: disposeBag)
    }
}
