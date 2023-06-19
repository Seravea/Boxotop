//
//  ActorImagesViewModel.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import Foundation


@MainActor class ActorImagesViewModel: ObservableObject {
    @Published var actorURLsImage: [PersonImageURL] = []
    
    
    func loadActorURLsImage(actorID: Int) async {
        let base: LoadingProperties = .actorImages(actorID: actorID)
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
            let decodedData = try decoder.decode(ImagesResponse.self, from: data)
                    
            self.actorURLsImage = decodedData.profiles
            
        }catch {
            fatalError("error when fetching data from TheMovieDatabase \(error)")
        }
        
    }
}
