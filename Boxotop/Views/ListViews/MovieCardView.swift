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
                .frame(height: 140)
                .foregroundColor(index % 2 == 0 ? .green : .gray)
            
            HStack(alignment: .top) {
                Rectangle()
                    .frame(width: 70, height: 100)
                VStack {
                    Text(movie.title)
                        .font(.title)
                    
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: Movie.testingMovie, index: 1)
    }
}
