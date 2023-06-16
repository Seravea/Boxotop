//
//  MovieDetails.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import SwiftUI

struct MovieDetails: View {
    let movie: Movie
    
    let casting = previewCastingResponse
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(movie.title)
                .font(.largeTitle)
                .padding(.horizontal)
         
            HStack(alignment: .top) {
                AsyncImage(url: movie.posterURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200)
                        .clipped()
                        .cornerRadius(9)
                        .shadow(radius: 0.1)
                } placeholder: {
                    ZStack {
                        ProgressView()
                            .progressViewStyle(.circular)
                        Rectangle()
                            .frame(width: 150, height: 200)
                            .cornerRadius(9)
                            .foregroundColor(.gray.opacity(0.9))
                            .padding(.trailing, 8)
                            .shadow(radius: 0.1)
                    }
                }
                
                VStack(alignment: .leading ,spacing: 15) {
                    Text("Release date: \(movie.releaseDate)")
                    Text("Audience : \(movie.voteAverage, specifier: "%.02f")")
                    Text("Vote count: \(movie.voteCount)")
                    
                }
                
            }
            .padding(.horizontal)
            List {
                
                Section("Synopsis") {
                    Text(movie.overview)
                }
                
                Section("Casting") {
                    ForEach(previewCastingResponse.cast.sorted(by: {$0.popularity > $1.popularity }).prefix(10), id: \.id) { person in
                        VStack {
                            Text(person.name)
                            Text("\(person.popularity)")
                        }
                    }
                }
                
                Section("Similar Movies") {
                    Text("List of similar movies")
                }
                
            }
            .listStyle(.plain)
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie: previewResponseData.results[2])
    }
}
