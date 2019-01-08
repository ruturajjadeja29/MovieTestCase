//
//  ExtensionUIApplication.swift
//  Movie
//
//  Created by mac-0009 on 08/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Extension of UIApplication For getting the TopMostViewController(UIViewController) of Application.
extension UIApplication {
    
    /// A Computed Property (only getter) of UIViewController For getting the TopMostViewController(UIViewController) of Application. For using this property you must have instance of UIApplication Like this:(UIApplication.shared).
    var topMostViewController:UIViewController {
        
        var topViewController = self.keyWindow?.rootViewController
        
        while topViewController?.presentedViewController != nil {
            topViewController = topViewController?.presentedViewController
        }
        
        return topViewController!
    }
    
}
