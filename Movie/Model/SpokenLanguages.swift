//
//  SpokenLanguages.swift
//
//  Created by mac-0009 on 07/01/19
//  Copyright (c) mac-0009. All rights reserved.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData

struct SpokenLanguages {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let iso6391 = "iso_639_1"
        static let name = "name"
    }
    
    // MARK: Properties
    public var iso6391: String?
    public var name: String?
    
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
        iso6391     = json[SerializationKeys.iso6391].string
        name        = json[SerializationKeys.name].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = iso6391 { dictionary[SerializationKeys.iso6391] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        return dictionary
    }
    
}

//MARK:-
//MARK:- Extenstion for Rx CoreData
extension SpokenLanguages: Equatable {
    static func == (lhs: SpokenLanguages, rhs: SpokenLanguages) -> Bool {
        return lhs.iso6391 == rhs.iso6391
    }
}

extension SpokenLanguages: IdentifiableType {
    typealias Identity = String
    var identity: Identity { return "\(iso6391 ?? "")" }
}

extension SpokenLanguages: Persistable {
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "TBLSpokenLanguages"
    }
    
    static var primaryAttributeName: String {
        return "iso6391"
    }
    
    init(entity: T) {
        iso6391         = entity.value(forKey: "iso6391") as? String
        name            = entity.value(forKey: "name") as? String
    }
    
    func update(_ entity: T) {
        entity.setValue(iso6391, forKey: "iso6391")
        entity.setValue(name, forKey: "name")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
}
