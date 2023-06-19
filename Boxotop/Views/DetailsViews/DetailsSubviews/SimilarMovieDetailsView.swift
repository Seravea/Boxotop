//
//  SimilarMovieDetailsView.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import SwiftUI

struct SimilarMovieDetailsView: View {
   @Binding var selectedMovie: Movie?
  
    var body: some View {
        if let movie = selectedMovie {
            
            VStack {
                HStack(alignment: .top) {
                    Text(movie.title)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button{
                        selectedMovie = nil
                    }label: {
                        Text("Done")
                    }
                }
                .padding([.horizontal, .top])
            ScrollView {
                Text(movie.overview)
                AsyncImage(url: movie.posterURL) { image in
                    ZStack {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 280)
                            .clipped()
                            .cornerRadius(9)
                            .shadow(radius: 0.5)
                    }
                } placeholder: {
                    ZStack(alignment: .topLeading) {
                        
                        Rectangle()
                            .cornerRadius(9)
                            .foregroundColor(.gray.opacity(0.8))
                           // .padding(.trailing, 8)
                            .shadow(radius: 0.1)
                        Text(movie.title)
                            .padding(10)
                            .font(.caption)
                    }
                    .frame(width: 100, height: 160)
                }
                
                
            }
            .padding(.horizontal)
        }
        }
    }
}

struct SimilarMovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarMovieDetailsView(selectedMovie: .constant(previewResponseData.results[0]))
    }
}
