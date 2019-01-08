//
//  Movie.swift
//
//  Created by mac-0009 on 07/01/19
//  Copyright (c) mac-0009. All rights reserved.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData

struct Movie {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let budget = "budget"
    static let backdropPath = "backdrop_path"
    static let revenue = "revenue"
    static let voteCount = "vote_count"
    static let overview = "overview"
    static let voteAverage = "vote_average"
    static let video = "video"
    static let imdbId = "imdb_id"
    static let id = "id"
    static let title = "title"
    static let homepage = "homepage"
    static let productionCompanies = "production_companies"
    static let posterPath = "poster_path"
    static let adult = "adult"
    static let genres = "genres"
    static let spokenLanguages = "spoken_languages"
    static let status = "status"
    static let runtime = "runtime"
    static let originalTitle = "original_title"
    static let releaseDate = "release_date"
    static let originalLanguage = "original_language"
    static let popularity = "popularity"
    static let tagline = "tagline"
    static let productionCountries = "production_countries"
  }

  // MARK: Properties
  public var budget: Int64?
  public var backdropPath: String?
  public var revenue: Int64?
  public var voteCount: Int64?
  public var overview: String?
  public var voteAverage: Int64?
  public var video: Bool? = false
  public var imdbId: String?
  public var id: Int64?
  public var title: String?
  public var homepage: String?
  public var productionCompanies: [ProductionCompanies]?
  public var posterPath: String?
  public var adult: Bool? = false
  public var genres: [Genres]?
  public var spokenLanguages: [SpokenLanguages]?
  public var status: String?
  public var runtime: Int64?
  public var originalTitle: String?
  public var releaseDate: String?
  public var originalLanguage: String?
  public var popularity: Double?
  public var tagline: String?
  public var productionCountries: [ProductionCountries]?

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
    budget              = json[SerializationKeys.budget].int64
    backdropPath        = json[SerializationKeys.backdropPath].string
    revenue             = json[SerializationKeys.revenue].int64
    voteCount           = json[SerializationKeys.voteCount].int64
    overview            = json[SerializationKeys.overview].string
    voteAverage         = json[SerializationKeys.voteAverage].int64
    video               = json[SerializationKeys.video].boolValue
    imdbId              = json[SerializationKeys.imdbId].string
    id                  = json[SerializationKeys.id].int64
    title               = json[SerializationKeys.title].string
    homepage            = json[SerializationKeys.homepage].string
    
    if let items = json[SerializationKeys.productionCompanies].array {
        productionCompanies = items.map { ProductionCompanies(json: $0) }
    }
    posterPath          = json[SerializationKeys.posterPath].string
    adult               = json[SerializationKeys.adult].boolValue
    
    if let items = json[SerializationKeys.genres].array {
        genres = items.map { Genres(json: $0) }
    }
    
    if let items = json[SerializationKeys.spokenLanguages].array {
        spokenLanguages = items.map { SpokenLanguages(json: $0) }
    }
    status              = json[SerializationKeys.status].string
    runtime             = json[SerializationKeys.runtime].int64
    originalTitle       = json[SerializationKeys.originalTitle].string
    releaseDate         = json[SerializationKeys.releaseDate].string
    originalLanguage    = json[SerializationKeys.originalLanguage].string
    popularity          = json[SerializationKeys.popularity].double
    tagline             = json[SerializationKeys.tagline].string
    
    if let items = json[SerializationKeys.productionCountries].array {
        productionCountries = items.map { ProductionCountries(json: $0) }
    }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = budget { dictionary[SerializationKeys.budget] = value }
    if let value = backdropPath { dictionary[SerializationKeys.backdropPath] = value }
    if let value = revenue { dictionary[SerializationKeys.revenue] = value }
    if let value = voteCount { dictionary[SerializationKeys.voteCount] = value }
    if let value = overview { dictionary[SerializationKeys.overview] = value }
    if let value = voteAverage { dictionary[SerializationKeys.voteAverage] = value }
    dictionary[SerializationKeys.video] = video
    if let value = imdbId { dictionary[SerializationKeys.imdbId] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = homepage { dictionary[SerializationKeys.homepage] = value }
    if let value = productionCompanies { dictionary[SerializationKeys.productionCompanies] = value.map { $0.dictionaryRepresentation() } }
    if let value = posterPath { dictionary[SerializationKeys.posterPath] = value }
    dictionary[SerializationKeys.adult] = adult
    if let value = genres { dictionary[SerializationKeys.genres] = value.map { $0.dictionaryRepresentation() } }
    if let value = spokenLanguages { dictionary[SerializationKeys.spokenLanguages] = value.map { $0.dictionaryRepresentation() } }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = runtime { dictionary[SerializationKeys.runtime] = value }
    if let value = originalTitle { dictionary[SerializationKeys.originalTitle] = value }
    if let value = releaseDate { dictionary[SerializationKeys.releaseDate] = value }
    if let value = originalLanguage { dictionary[SerializationKeys.originalLanguage] = value }
    if let value = popularity { dictionary[SerializationKeys.popularity] = value }
    if let value = tagline { dictionary[SerializationKeys.tagline] = value }
    if let value = productionCountries { dictionary[SerializationKeys.productionCountries] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

}

//MARK:-
//MARK:- Extenstion for Rx CoreData
extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Movie: IdentifiableType {
    typealias Identity = String
    var identity: Identity { return "\(id ?? 0)" }
}

extension Movie: Persistable {
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "TBLMovie"
    }
    
    static var primaryAttributeName: String {
        return "id"
    }
    
    init(entity: T) {
        
        //...Preparing list by array
        var arrGenres = [Genres]()
        if let arrGenresCoredata = (entity as? TBLMovie)?.genres {
            for genreCoredata in arrGenresCoredata.allObjects {
                if let genreCoredata = genreCoredata as? TBLGenres {
                    arrGenres.append(Genres(entity: genreCoredata))
                }
            }
        }
        
        var arrProductionCompanies = [ProductionCompanies]()
        if let arrProductionCompaniesCoredata = (entity as? TBLMovie)?.productionCompanies {
            for productionCompanyCoredata in arrProductionCompaniesCoredata.allObjects {
                if let productionCompanyCoredata = productionCompanyCoredata as? TBLProductionCompanies {
                    arrProductionCompanies.append(ProductionCompanies(entity: productionCompanyCoredata))
                }
            }
        }
        
        var arrSpokenLanguages = [SpokenLanguages]()
        if let arrSpokenLanguagesCoredata = (entity as? TBLMovie)?.spokenLanguages {
            for spokenLanguageCoredata in arrSpokenLanguagesCoredata.allObjects {
                if let spokenLanguageCoredata = spokenLanguageCoredata as? TBLSpokenLanguages {
                    arrSpokenLanguages.append(SpokenLanguages(entity: spokenLanguageCoredata))
                }
            }
        }
        
        var arrProductionCountries = [ProductionCountries]()
        if let arrProductionCountriesCoredata = (entity as? TBLMovie)?.productionCountries {
            for productionCountryCoredata in arrProductionCountriesCoredata.allObjects {
                if let productionCountryCoredata = productionCountryCoredata as? TBLSpokenLanguages {
                    arrProductionCountries.append(ProductionCountries(entity: productionCountryCoredata))
                }
            }
        }
        
        //...
        budget                  = entity.value(forKey: "budget") as? Int64
        adult                   = entity.value(forKey: "adult") as? Bool
        backdropPath            = entity.value(forKey: "backdropPath") as? String
        homepage                = entity.value(forKey: "homepage") as? String
        genres                  = arrGenres
        productionCompanies     = arrProductionCompanies
        spokenLanguages         = arrSpokenLanguages
        productionCountries     = arrProductionCountries
        productionCountries     = entity.value(forKey: "productionCountries") as? [ProductionCountries]
        id                      = entity.value(forKey: "id") as? Int64
        originalLanguage        = entity.value(forKey: "originalLanguage") as? String
        originalTitle           = entity.value(forKey: "originalTitle") as? String
        overview                = entity.value(forKey: "overview") as? String
        popularity              = entity.value(forKey: "popularity") as? Double
        posterPath              = entity.value(forKey: "posterPath") as? String
        releaseDate             = entity.value(forKey: "releaseDate") as? String
        title                   = entity.value(forKey: "title") as? String
        video                   = entity.value(forKey: "video") as? Bool
        voteAverage             = entity.value(forKey: "voteAverage") as? Int64
        voteCount               = entity.value(forKey: "voteCount") as? Int64
        runtime                 = entity.value(forKey: "runtime") as? Int64
        status                  = entity.value(forKey: "status") as? String
        tagline                 = entity.value(forKey: "tagline") as? String
        imdbId                  = entity.value(forKey: "imdbId") as? String
    }
    
    func update(_ entity: T) {
        
        //...Preparing list by array
        var arrGenres = [TBLGenres]()
        for genre in (self.genres ?? []) {
            try? CAppdelegate?.persistentContainer.viewContext.rx.update(genre)
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Genres.entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %d", genre.id ?? 0)
            do {
                if let genreDB = try CAppdelegate?.persistentContainer.viewContext.fetch(fetchRequest).last as? TBLGenres {
                    arrGenres.append(genreDB)
                }
            } catch {
                
            }
        }
        
        var arrProductionCompanies = [TBLProductionCompanies]()
        for productionCompany in (self.productionCompanies ?? []) {
            try? CAppdelegate?.persistentContainer.viewContext.rx.update(productionCompany)
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ProductionCompanies.entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %d", productionCompany.id ?? 0)
            do {
                if let productionCompanyDB = try CAppdelegate?.persistentContainer.viewContext.fetch(fetchRequest).last as? TBLProductionCompanies {
                    arrProductionCompanies.append(productionCompanyDB)
                }
            } catch {
                
            }
        }
        
        var arrSpokenLanguages = [TBLSpokenLanguages]()
        for spokenLanguage in (self.spokenLanguages ?? []) {
            try? CAppdelegate?.persistentContainer.viewContext.rx.update(spokenLanguage)
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: SpokenLanguages.entityName)
            fetchRequest.predicate = NSPredicate(format: "iso6391 == %@", spokenLanguage.iso6391 ?? "")
            do {
                if let spokenLanguageDB = try CAppdelegate?.persistentContainer.viewContext.fetch(fetchRequest).last as? TBLSpokenLanguages {
                    arrSpokenLanguages.append(spokenLanguageDB)
                }
            } catch {
                
            }
        }
        
        var arrProductionCountries = [TBLProductionCountries]()
        for productionCountry in (self.productionCountries ?? []) {
            try? CAppdelegate?.persistentContainer.viewContext.rx.update(productionCountry)
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ProductionCountries.entityName)
            fetchRequest.predicate = NSPredicate(format: "iso31661 == %@", productionCountry.iso31661 ?? "")
            do {
                if let productionCountryDB = try CAppdelegate?.persistentContainer.viewContext.fetch(fetchRequest).last as? TBLProductionCountries {
                    arrProductionCountries.append(productionCountryDB)
                }
            } catch {
                
            }
        }
        
        //...
        entity.setValue(budget, forKey: "budget")
        entity.setValue(adult, forKey: "adult")
        entity.setValue(backdropPath, forKey: "backdropPath")
        entity.setValue(homepage, forKey: "homepage")
        entity.setValue(NSSet(array: arrGenres), forKey: "genres")
        entity.setValue(NSSet(array: arrProductionCompanies), forKey: "productionCompanies")
        entity.setValue(NSSet(array: arrSpokenLanguages), forKey: "spokenLanguages")
        entity.setValue(NSSet(array: arrProductionCountries), forKey: "productionCountries")
        entity.setValue(id, forKey: "id")
        entity.setValue(originalLanguage, forKey: "originalLanguage")
        entity.setValue(originalTitle, forKey: "originalTitle")
        entity.setValue(overview, forKey: "overview")
        entity.setValue(popularity, forKey: "popularity")
        entity.setValue(posterPath, forKey: "posterPath")
        entity.setValue(releaseDate, forKey: "releaseDate")
        entity.setValue(title, forKey: "title")
        entity.setValue(video, forKey: "video")
        entity.setValue(voteAverage, forKey: "voteAverage")
        entity.setValue(voteCount, forKey: "voteCount")
        entity.setValue(runtime, forKey: "runtime")
        entity.setValue(status, forKey: "status")
        entity.setValue(tagline, forKey: "tagline")
        entity.setValue(imdbId, forKey: "imdbId")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
}
