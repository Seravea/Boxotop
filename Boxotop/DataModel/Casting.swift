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

