//
//  MovieDetailsViewModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import Foundation


@MainActor class MovieDetailsViewModel: ObservableObject {
    @Published private(set) var movieCasting: CastingResponse?
    @Published private(set) var similarMovies: [Movie] = []
    
    
    private func loadMovieCasting(movieID: Int) async {
        
        let base: LoadingProperties = .actorsList(movieID: movieID)
        
        do {
            guard base.ApiURL != nil else {
                print("Couldn't load URL")
                return
            }
            
            let (data, networkResponse) = try await URLSession.shared.data(for: base.myURLRequest)
            
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
    
    
    private func loadSimilarMovies(movieID: Int) async {
        
        let base: LoadingProperties = .similarMovies(movieID: movieID)
        
        do {
            guard base.ApiURL != nil else {
                print("Couldn't load URL")
                return
            }
            
            
            let (data, networkResponse) = try await URLSession.shared.data(for: base.myURLRequest)
            
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
    
    
    func fetchingDataDetailsView(movieID: Int) async {
        Task {
            await loadMovieCasting(movieID: movieID)
            await loadSimilarMovies(movieID: movieID)
            print("this movie is showing")
        }
    }
    
    
}
