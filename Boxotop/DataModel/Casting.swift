//
//  Casting.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import Foundation


struct CastingResponse: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable {
    let adult: Bool
    let id: Int
    let name: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, id
        case name
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case order
    }
}

struct ImagesResponse: Codable {
    let id: Int
    let profiles: [PersonImageURL]
}


struct PersonImageURL: Codable {
    let filePath: String?
    
    var imageURL: URL? {
        if let path = filePath {
            let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")!
            return baseURL.appending(path: path)
        }else {
            return nil
        }
    }

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
