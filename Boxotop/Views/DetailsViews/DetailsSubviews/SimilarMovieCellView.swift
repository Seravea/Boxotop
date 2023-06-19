//
//  SimilarMovieCellView.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import SwiftUI

struct SimilarMovieCellView: View {
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
}


struct SimilarMovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarMovieCellView(movie: previewResponseData.results[0])
    }
}
