//
//  MovieDetails.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import SwiftUI

struct MovieDetails: View {
    
    let movie: Movie
    
    @StateObject var movieDetailsViewModel = MovieDetailsViewModel()
    
    @State var selectedSimilarMovie: Movie?
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
                
                VStack(alignment: .leading) {
                    
                    Text("Release date:")
                    Text("\(movie.releaseDate)")
                        .padding(.bottom, 10)
                    
                    Text("Audience :")
                    StarsNotationView(vote: movie.voteAverage)
                        .padding(.bottom, 10)
                    
                    Text("Vote count:")
                    Text("\(movie.voteCount)")
                        .padding(.bottom, 10)
                    
                    Text("My rating:")
                    MyMovieRatingView(movieID: movie.id)
                }
                
            }
            .padding(.horizontal)
            List {
                
                Section("Synopsis") {
                    Text(movie.overview)
                }
                
                Section("Casting") {
                    if let casting = movieDetailsViewModel.movieCasting {
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(casting.cast.sorted(by: {$0.order < $1.order}).prefix(5), id: \.id) { person in
                                   
                                    ActorCellView(person: person)
                                     
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                
                Section("Similar Movies") {
                    if movieDetailsViewModel.similarMovies.isEmpty == false {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(movieDetailsViewModel.similarMovies, id: \.id) { similarMovie in
                                    Button {
                                        selectedSimilarMovie = similarMovie
                                        
                                    } label: {
                                        SimilarMovieCellView(movie: similarMovie)
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                    }
                                    

                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                    }
                }
                .sheet(item: $selectedSimilarMovie) { movie in
                    SimilarMovieDetailsView(selectedMovie: $selectedSimilarMovie)
                        .presentationDetents([.medium])
                }
                
            }
            .listStyle(.plain)
            .task {
                await movieDetailsViewModel.loadMovieCasting(movieID: movie.id)
                await movieDetailsViewModel.loadSimilarMovies(movieID: movie.id)
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie: previewResponseData.results[4])
    }
}



