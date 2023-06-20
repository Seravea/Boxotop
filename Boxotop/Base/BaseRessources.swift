//
//  BaseRessources.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import Foundation



enum LoadingProperties {
    case boxOfficeMovies
    case similarMovies(movieID: Int)
    case actorsList(movieID: Int)
    case actorImages(actorID: Int)
    case defaultRessources
    
    var apiKey: String {
        "eed456115041deb5c36ed519eafea41a"
        
    }
    var headers: [String : String] {
        [
            "accept": "application/json",
            "Authorization": "Bearer eed456115041deb5c36ed519eafea41a"
        ]
    }
    
    var ApiURL: URL? {
        switch self {
        case .boxOfficeMovies:
            return URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1")!
        case .similarMovies(let movieID):
            return URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/similar?api_key=\(apiKey)&language=us-US&page=1")!
        case .actorsList(let movieID):
            return URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(apiKey)&language=us-US")!
        case .actorImages(let actorID):
            return URL(string: "https://api.themoviedb.org/3/person/\(actorID)/images?api_key=\(apiKey)")!
        case.defaultRessources:
            return nil
        }
    }
    
    /*
     var urlRequest = URLRequest(url: url)
     urlRequest.httpMethod = "GET"
     urlRequest.allHTTPHeaderFields = LoadingProperties.defaultRessources.headers
     */
    var myURLRequest: URLRequest {
        var returnURLRequest = URLRequest(url: self.ApiURL!)
        returnURLRequest.httpMethod = "GET"
        returnURLRequest.allHTTPHeaderFields = headers
        return returnURLRequest
    }
    
    
    
    
    
}
