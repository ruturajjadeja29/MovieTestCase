//
//  ExtesionNSManagedObjectContext.swift
//  Movie
//
//  Created by mac-0009 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func saveChanges() {
        if self.hasChanges {
            do { try save() }
            catch { print("Error while saving the Single Change into NSManagedObjectContext :- \(error.localizedDescription)") }
        }
    }
}
