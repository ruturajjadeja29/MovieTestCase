//
//  MovieDetailVC.swift
//  Movie
//
//  Created by mac-0008 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    // MARK: -
    // MARK: - @IBOutlets.
    @IBOutlet weak var tblVMovieDetail: UITableView!
    
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
    
        self.title = "Venom"
    }
}

