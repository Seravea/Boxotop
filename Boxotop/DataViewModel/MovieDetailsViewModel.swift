//
//  MovieDetailsViewModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import Foundation


@MainActor class MovieDetailsViewModel: ObservableObject {
    @Published var movieCasting: CastingResponse?
    @Published var similarMovies: [Movie] = []
    
    
    func loadMovieCasting(movieID: Int) async {
       
        do {
            guard let url = LoadingProperties.actorsList(movieID: movieID).ApiURL else {
                print("Couldn't load URL")
                return
            }
            
            
            var URLRequest = URLRequest(url: url)
            URLRequest.httpMethod = "GET"
            URLRequest.allHTTPHeaderFields = LoadingProperties.boxOfficeMovies.headers
            
            
            let (data, networkResponse) = try await URLSession.shared.data(for: URLRequest)
            
            guard (networkResponse as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error when fetching data on the URLSession \(networkResponse)")
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(CastingResponse.self, from: data)
                    
            self.movieCasting = decodedData
            
        }catch {
            fatalError("error when fetching data from TheMovieDatabase \(error)")
        }
        
    }
    
    
    func loadSimilarMovies(movieID: Int) async {
        
        do {
            guard let url = LoadingProperties.similarMovies(movieID: movieID).ApiURL else {
                print("Couldn't load URL")
                return
            }
            
            
            var URLRequest = URLRequest(url: url)
            URLRequest.httpMethod = "GET"
            URLRequest.allHTTPHeaderFields = LoadingProperties.defaultRessources.headers
            
            
            let (data, networkResponse) = try await URLSession.shared.data(for: URLRequest)
            
            guard (networkResponse as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error when fetching data on the URLSession \(networkResponse)")
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(MoviesResponse.self, from: data)
                    
            self.similarMovies = decodedData.results
            
        }catch {
            fatalError("error when fetching data from TheMovieDatabase \(error)")
        }
        
        
    }
    
    
}
