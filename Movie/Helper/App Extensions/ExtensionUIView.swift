//
//  ExtensionUIView.swift
//  Movie
//
//  Created by mac-0009 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    var CViewSize: CGSize {
        return self.frame.size
    }
    
    var CViewOrigin: CGPoint {
        return self.frame.origin
    }
    
    var CViewWidth: CGFloat {
        return self.CViewSize.width
    }
    
    var CViewHeight: CGFloat {
        return self.CViewSize.height
    }
    
    var CViewX: CGFloat {
        return self.CViewOrigin.x
    }
    
    var CViewY: CGFloat {
        return self.CViewOrigin.y
    }
    
    var CViewCenter: CGPoint {
        return CGPoint(x: self.CViewWidth/2.0, y: self.CViewHeight/2.0)
    }
    
    var CViewCenterX: CGFloat {
        return CViewCenter.x
    }
    
    var CViewCenterY: CGFloat {
        return CViewCenter.y
    }
    
}

extension UIView {
    
    func CViewSetSize(width: CGFloat, height: CGFloat) {
        CViewSetWidth(width: width)
        CViewSetHeight(height: height)
    }
    
    func CViewSetOrigin(x: CGFloat, y: CGFloat) {
        CViewSetX(x: x)
        CViewSetY(y: y)
    }
    
    func CViewSetWidth(width: CGFloat) {
        self.frame.size.width = width
    }
    
    func CViewSetHeight(height: CGFloat) {
        self.frame.size.height = height
    }
    
    func CViewSetX(x: CGFloat) {
        self.frame.origin.x = x
    }
    
    func CViewSetY(y: CGFloat) {
        self.frame.origin.y = y
    }
    
    func CViewSetCenter(x: CGFloat, y: CGFloat) {
        CViewSetCenterX(x: x)
        CViewSetCenterY(y: y)
    }
    
    func CViewSetCenterX(x: CGFloat) {
        self.center.x = x
    }
    
    func CViewSetCenterY(y: CGFloat) {
        self.center.y = y
    }
}
