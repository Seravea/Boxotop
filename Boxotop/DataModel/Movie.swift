//
//  Movie.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import Foundation

// struct of the API Response from the JSON
struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

//struct of a Movie
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String
    let originalTitle, overview, posterPath: String
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var posterURL: URL {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")!
        return baseURL.appending(path: posterPath)
    }
    

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}



enum MediaType: String, Codable {
    case movie = "movie"
}



