//
//  MovieCardView.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    let index: Int
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 150)
                .foregroundColor(index % 2 == 0 ? .green.opacity(0.2) : .gray.opacity(0.2))
                .shadow(radius: 0.1)
            
            HStack(alignment: .top) {
                
                AsyncImage(url: movie.posterURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 130)
                        .clipped()
                        .cornerRadius(9)
                        .shadow(radius: 0.1)
                } placeholder: {
                    ZStack {
                        ProgressView()
                            .progressViewStyle(.circular)
                        Rectangle()
                            .frame(width: 90, height: 130)
                            .cornerRadius(9)
                            .foregroundColor(.gray.opacity(0.9))
                            .padding(.trailing, 8)
                            .shadow(radius: 0.1)
                    }
                }

                VStack {
                    Text(movie.title)
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    
                }
                
            }
            .padding(.horizontal)
        }
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: previewResponseData.results[2], index: 1)
    }
}
