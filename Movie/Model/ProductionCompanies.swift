//
//  ProductionCompanies.swift
//
//  Created by mac-0009 on 07/01/19
//  Copyright (c) mac-0009. All rights reserved.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData

struct ProductionCompanies {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let originCountry = "origin_country"
        static let name = "name"
        static let id = "id"
    }
    
    // MARK: Properties
    public var originCountry: String?
    public var name: String?
    public var id: Int64?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public init(json: JSON) {
        originCountry   = json[SerializationKeys.originCountry].string
        name            = json[SerializationKeys.name].string
        id              = json[SerializationKeys.id].int64
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = originCountry { dictionary[SerializationKeys.originCountry] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        return dictionary
    }
    
}


//MARK:-
//MARK:- Extenstion for Rx CoreData
extension ProductionCompanies: Equatable {
    static func == (lhs: ProductionCompanies, rhs: ProductionCompanies) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ProductionCompanies: IdentifiableType {
    typealias Identity = String
    var identity: Identity { return "\(id ?? 0)" }
}

extension ProductionCompanies: Persistable {
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "TBLProductionCompanies"
    }
    
    static var primaryAttributeName: String {
        return "id"
    }
    
    init(entity: T) {
        id                  = entity.value(forKey: "id") as? Int64
        name                = entity.value(forKey: "name") as? String
        originCountry       = entity.value(forKey: "originCountry") as? String
    }
    
    func update(_ entity: T) {
        entity.setValue(id, forKey: "id")
        entity.setValue(name, forKey: "name")
        entity.setValue(originCountry, forKey: "originCountry")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
}
