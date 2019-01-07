//
//  ProductionCountries.swift
//
//  Created by mac-0009 on 07/01/19
//  Copyright (c) mac-0009. All rights reserved.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData

struct ProductionCountries {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let iso31661 = "iso_3166_1"
  }

  // MARK: Properties
  public var name: String?
  public var iso31661: String?

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
    name = json[SerializationKeys.name].string
    iso31661 = json[SerializationKeys.iso31661].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = iso31661 { dictionary[SerializationKeys.iso31661] = value }
    return dictionary
  }

}

extension ProductionCountries : Equatable {
    static func == (lhs: ProductionCountries, rhs: ProductionCountries) -> Bool {
        return lhs.iso31661 == rhs.iso31661
    }
}

extension ProductionCountries : IdentifiableType {
    typealias Identity = String
    
    var identity: Identity { return "\(iso31661 ?? "")" }
}

extension ProductionCountries : Persistable {
    
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "TBLProductionCountries"
    }
    
    static var primaryAttributeName: String {
        return "iso31661"
    }
    
    init(entity: T) {
        iso31661                  = entity.value(forKey: "iso31661") as? String
        name                = entity.value(forKey: "name") as? String
    }
    
    func update(_ entity: T) {
        
        entity.setValue(iso31661, forKey: "iso31661")
        entity.setValue(name, forKey: "name")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
        
    }
    
}
