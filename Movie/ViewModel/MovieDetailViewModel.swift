//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by mac-0008 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class MovieDetailViewModel {
    
    // MARK: -
    // MARK: - Singleton.
    private init() {}
    
    private static var movieDetailViewModel: MovieDetailViewModel = {
        let movieDetailViewModel = MovieDetailViewModel()
        return movieDetailViewModel
    }()
    
    static var shared: MovieDetailViewModel {
        return movieDetailViewModel
    }
    
    // MARK: -
    // MARK: - Rx-Swift Observable.
    var arrDetailCustom:Variable<[MovieDetailModel]> = Variable([])
    var movieHeader:Variable<MovieHeaderModel> = Variable(Mapper<MovieHeaderModel>().map(JSON: [:])!)
    
}

// MARK: -
// MARK: - General Methods.
extension MovieDetailViewModel {
    
    func loadMovieDetailsFromServer() {
        
        _ = APIRequest.shared.movieDetails(movieID: 297802, successCompletion: { (response, status) in
            
            let keyAry = ["overview","genres","runtime","release_date","production_companies","budget","revenue","spoken_languages"]
            
            if let responseDict = response as? [String: Any] {
                
                for key in keyAry {
                    if responseDict.keys.contains(key) {
                        
                        if let obj = Mapper<MovieDetailModel>().map(JSON: ["title" : self.getTitle(key: key) , "contents": self.getMyContent(input: responseDict[key] ?? "", key: key)]) {
                            self.arrDetailCustom.value.append(obj)
                        }
                    }
                }
                
                if let movieHeaderModel = (Mapper<MovieHeaderModel>().map(JSON: responseDict)) {
                    self.movieHeader.value = movieHeaderModel
                }
            }
        }, failureCompletion: nil)
    }
    
    func getMyContent(input:Any, key: String) -> String {
        
        switch key {
        case "genres" :
            return getFormattedString(input: input)
            
        case "production_companies" :
            return getFormattedString(input: input)
            
        case "spoken_languages" :
            return getFormattedString(input: input)
            
        default:
            
            if let subTitle = input as? Int {
                if (key == "runtime") {
                    return "\(subTitle) Minutes"
                } else if (key == "budget" || key == "revenue") {
                    return "$\(subTitle)"
                }
            } else if let strSubtitle = input as? String {
                return strSubtitle
            }
        }
        return ""
    }
    
    fileprivate func getTitle(key: String) -> String {
        
        switch key {
            
        case "overview":
            return "Overview"
        case "genres":
            return "Genres"
        case "runtime":
            return "Duration"
        case "release_date":
            return "Release Date"
        case "production_companies":
            return "Production Companies"
        case "budget":
            return "Production Budget"
        case "revenue":
            return "Revenue"
        default:
            return "Languages"
        }
    }
    
    fileprivate func getFormattedString(input: Any) -> String {
        
        if let arrTemp = input as? Array<[String: Any]> {
            let arrString = arrTemp.map{ $0["name"]}
            if let arr = arrString as? [String] {
                return arr.joined(separator: ", ")
            }
        }
        return ""
    }
}
