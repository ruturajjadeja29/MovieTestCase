//
//  CoreDataManager.swift
//  Movie
//
//  Created by mac-0009 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    private init() {}
    
    private static var coreDataManager:CoreDataManager = {
        let coreDataManager = CoreDataManager()
        return coreDataManager
    }()
    
    static var shared:CoreDataManager = {
        return coreDataManager
    }()
    
    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Movie")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy private(set) var mainManagedObjectContext:NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
}

extension CoreDataManager {
    
    func save() {
        mainManagedObjectContext.saveChanges()
    }
}
