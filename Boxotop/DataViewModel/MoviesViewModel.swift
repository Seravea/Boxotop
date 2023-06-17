//
//  MoviesViewModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import Foundation

@MainActor class MovieViewModel: ObservableObject {
    @Published private(set) var boxOfficeMovies: [Movie] = []
    let apiKey = "eed456115041deb5c36ed519eafea41a"
    let headers = [
        "accept": "application/json",
        "Authorization": "Bearer eed456115041deb5c36ed519eafea41a"
    ]
    
    
    
    func loadBoxOfficeMovies() async {

        
        do {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1") else {
                print("Couldn't load URL")
                return
            }
              
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.allHTTPHeaderFields = headers
            
            
            let (data, networkResponse) = try await URLSession.shared.data(for: urlRequest)
            
            guard (networkResponse as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error when fetching data on the URLSession \(networkResponse)")
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(MoviesResponse.self, from: data)
            
            self.boxOfficeMovies = decodedData.results
        }catch {
            fatalError("error when fetching data from TheMovieDatabase \(error)")
        }
        
        
    }
    
    
}
