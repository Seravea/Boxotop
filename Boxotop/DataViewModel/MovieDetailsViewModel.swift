//
//  MovieDetailsViewModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import Foundation


class MovieDetailsViewModel: ObservableObject {
    @Published var movieCasting: [Cast] = []
    
    
    
    func loadMovieCasting(movieID: Int) async {
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eed456115041deb5c36ed519eafea41a"
        ]
        
        let apiKey = "eed456115041deb5c36ed519eafea41a"
        
        do {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(apiKey)&language=fr-FR") else {
                print("Couldn't load URL")
                return
            }
            
            
            var URLRequest = URLRequest(url: url)
            URLRequest.httpMethod = "GET"
            URLRequest.allHTTPHeaderFields = headers
            
            
            let (data, networkResponse) = try await URLSession.shared.data(for: URLRequest)
            
            guard (networkResponse as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error when fetching data on the URLSession \(networkResponse)")
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(CastingResponse.self, from: data)
                    
            self.movieCasting = decodedData.cast.sorted(by: {$0.popularity > $1.popularity })
            
        }catch {
            fatalError("error when fetching data from TheMovieDatabase \(error)")
        }
        
    }
    
    
    
}
