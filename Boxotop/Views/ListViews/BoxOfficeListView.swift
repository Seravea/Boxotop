//
//  BoxOfficeListView.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import SwiftUI

struct BoxOfficeListView: View {
    
    //var previewDataTest = previewResponseData
    @StateObject var movieViewModel = MovieViewModel()
    var body: some View {
        NavigationView {
            VStack {
                
                ScrollView {
                    ForEach(movieViewModel.boxOfficeMovies.indices, id: \.self) { index in
                        NavigationLink {
                            MovieDetails(movie: movieViewModel.boxOfficeMovies[index])
                        }label: {
                            MovieCardView(movie: movieViewModel.boxOfficeMovies[index], index: index)
                        }
                        .tint(.black)
                        
                    }
                    
                }
                .padding(.horizontal)
                .scrollIndicators(.hidden)
                
            }
            .task {
                await movieViewModel.loadBoxOfficeMovies()
            }
            .navigationTitle("Box office")
        }
    }
}

struct BoxOfficeListView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOfficeListView()
    }
}
