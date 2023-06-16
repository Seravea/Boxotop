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
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
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


extension Movie {
    
    static let testingMovie: Movie = Movie(adult: false, backdropPath: "/4XM8DUTQb3lhLemJC51Jx4a2EuA.jpg", id: 385687, title: "Fast X", originalTitle: "Fast X", overview: "Over many missions and against impossible odds, Dom Toretto and his family have outsmarted, out-nerved and outdriven every foe in their path. Now, they confront the most lethal opponent they've ever faced: A terrifying threat emerging from the shadows of the past who's fueled by blood revenge, and who is determined to shatter this family and destroy everything—and everyone—that Dom loves, forever.", posterPath: "/fiVW06jE7z9YnO4trhaMEdclSiC.jpg", mediaType: .movie, genreIDS: [28,80,53], popularity: 3047.913, releaseDate: "2023-05-17", video: false, voteAverage: 7.297, voteCount: 1002)
}
