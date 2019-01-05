//
//  ExtensionURL.swift
//  Movie
//
//  Created by mac-0009 on 05/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation

// MARK: - Extension of URL For Converting it TO String.
extension URL {
    
    /// A Computed Property (only getter) of URL For getting the String value from URL.
    /// This Computed Property (only getter) returns String? , it means this Computed Property (only getter) return nil value also , while using this Computed Property (only getter) please use if let. If you are not using if let and if this Computed Property (only getter) returns nil and when you are trying to unwrapped this value("String!") then application will crash.
    var toString:String? {
        return self.absoluteString
    }
}
