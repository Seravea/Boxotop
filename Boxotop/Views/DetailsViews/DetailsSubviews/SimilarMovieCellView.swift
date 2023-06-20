//
//  SimilarMovieCellView.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import SwiftUI

struct SimilarMovieCellView: View {
    @Environment (\.colorScheme) var colorScheme
    
    let movie: Movie
    var body: some View {
        AsyncImage(url: movie.posterURL) { image in
            ZStack {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 160)
                    .clipped()
                    .cornerRadius(9)
                    .shadow(color: shadowColorOnColorScheme(colorSchemeToCheck: colorScheme), radius: 1)
            }
        } placeholder: {
            ZStack(alignment: .topLeading) {
                
                Rectangle()
                    .cornerRadius(9)
                    .foregroundColor(.gray.opacity(0.8))
                    .shadow(radius: 0.1)
                Text(movie.title)
                    .padding(10)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
            }
            .frame(width: 100, height: 160)
        }
    }
}


struct SimilarMovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarMovieCellView(movie: previewResponseData.results[0])
    }
}
