//
//  SimilarMovieDetailsView.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import SwiftUI

struct SimilarMovieDetailsView: View {
    let movie: Movie
    @Binding var isShowingOverview: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(movie.title)
                .font(.title)
                .bold()
            
            Text(movie.overview)
            
        }
        .padding(.horizontal)
    }
}

struct SimilarMovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarMovieDetailsView(movie: previewResponseData.results[0], isShowingOverview: .constant(true))
    }
}
