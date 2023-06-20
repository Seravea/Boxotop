//
//  BoxOfficeListView.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import SwiftUI

struct BoxOfficeListView: View {
    
    @State var mySearchText: String = ""
    @StateObject var movieViewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            if movieViewModel.boxOfficeMovies.isEmpty {
               ProgressView()
                    .progressViewStyle(.circular)
                .task {
                    await movieViewModel.loadBoxOfficeMovies()
                }
            }else {
                VStack {
                    
                    ScrollView {
                        ForEach(movieViewModel.boxOfficeMovies.filter({
                            
                            mySearchText.isEmpty ? true :
                            $0.title.localizedCaseInsensitiveContains(mySearchText.lowercased())
                            
                            
                        }), id: \.id) { movie in
                            NavigationLink {
                                MovieDetails(movie: movie)
                            }label: {
                                MovieCardView(movie: movie, index: findIndex(movies: movieViewModel.boxOfficeMovies, movieToCheck: movie))
                            }
                            .tint(.black)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    .scrollIndicators(.hidden)
                    
                }
                .navigationTitle("Box office")
                .searchable(text: $mySearchText)
            }
            
        }
    }
}

struct BoxOfficeListView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOfficeListView()
    }
}
