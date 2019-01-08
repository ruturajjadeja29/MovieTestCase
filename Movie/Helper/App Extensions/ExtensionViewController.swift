//
//  ExtensionViewController.swift
//  Movie
//
//  Created by mac-0009 on 08/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayAPIErrorWith(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
