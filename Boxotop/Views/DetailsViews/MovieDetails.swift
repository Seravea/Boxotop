//
//  MovieDetails.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import SwiftUI

struct MovieDetails: View {
    @Environment(\.colorScheme) var colorScheme
  
    let movie: Movie
    
    @StateObject var movieDetailsViewModel = MovieDetailsViewModel()
    
    @State var selectedSimilarMovie: Movie?
    
    @State var zoomOnPoster: Bool = false
    var body: some View {

        VStack(alignment: .leading) {
            
            Text(movie.title)
                .font(.largeTitle)
                .padding(.horizontal)
            
            
            List {
                
                
                HStack(spacing: 20) {
                    
                    ZStack(alignment: .bottomTrailing) {
                        
                        AsyncImage(url: movie.posterURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: zoomOnPoster ? 300 : 150, height: zoomOnPoster ? 400 : 200)
                                .clipped()
                                .cornerRadius(9)
                                .shadow(color: shadowColorOnColorScheme(colorSchemeToCheck: colorScheme) , radius: 0.5)
                                
                        } placeholder: {
                            
                            Rectangle()
                                .frame(width: 150, height: 200)
                                .cornerRadius(9)
                                .foregroundColor(.gray.opacity(0.9))
                                .padding(.trailing, 8)
                                .shadow(radius: 0.1)
                        
                        }
                        
                        Button {
                            withAnimation(.spring()) {
                                zoomOnPoster.toggle()
                            }
                            
                        }label: {
                            Image(systemName: "\(zoomOnPoster ? "minus" : "plus").magnifyingglass")
                                .foregroundColor(.black)
                                .padding(5)
                                .background(Circle().foregroundColor(.myGreen.opacity(0.8)))
                        }
                        .buttonStyle(.borderless)
                        .padding(2)
                       
                        
                    }
                    if zoomOnPoster == false {
                        VStack(alignment: .leading) {
                            
                            Text("Release date:")
                            Text("\(movie.releaseDate)")
                                .padding(.bottom, 5)
                            
                            Text("Audience :")
                            StarsNotationView(vote: movie.voteAverage)
                                .padding(.bottom, 5)
                            
                            Text("Vote count:")
                            Text("\(movie.voteCount)")
                                .padding(.bottom, 5)
                            
                            Text("My rating:")
                            MyMovieRatingView(movieID: movie.id)
                        }
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                }
                .padding(.horizontal)
                    
                
                
                Section("Synopsis") {
                    Text(movie.overview)
                }
                
                Section("Casting") {
                    if let casting = movieDetailsViewModel.movieCasting {
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(casting.cast.sorted(by: {$0.order < $1.order}).prefix(5), id: \.id) { person in
                                    
                                    ActorCellView(person: person)
                                        .padding(.vertical, 5)
                                    
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
                        .presentationDetents([.medium, .large])
                    
                }
                
                
            }
            .listStyle(.plain)
            .task {
                await movieDetailsViewModel.fetchingDataDetailsView(movieID: movie.id)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
      
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie: previewResponseData.results[14])
    }
}



