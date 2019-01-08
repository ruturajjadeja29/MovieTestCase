//
//  ParentVC.swift
//  Movie
//
//  Created by mac-0008 on 08/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit

class ParentVC: UIViewController {

    // MARK: -
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //...
        self.navigationController?.navigationBar.barTintColor = CRGB(r: 41, g: 51, b: 71)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //...
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
