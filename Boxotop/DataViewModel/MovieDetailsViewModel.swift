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
       
        let base: LoadingProperties = .actorsList(movieID: movieID)
        
        do {
            guard let url = base.ApiURL else {
                print("Couldn't load URL")
                return
            }
            
            
            var URLRequest = base.baseURLRequest
            
            
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
        
        let base: LoadingProperties = .similarMovies(movieID: movieID)
        
        do {
            guard let url = base.ApiURL else {
                print("Couldn't load URL")
                return
            }
            
            var URLRequest = base.baseURLRequest
            
            
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
