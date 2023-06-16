//
//  BoxOfficeListView.swift
//  Boxotop
//
//  Created by Romain Poyard on 16/06/2023.
//

import SwiftUI

struct BoxOfficeListView: View {
    
    var previewDataTest = previewResponseData
    
    var body: some View {
        NavigationView {
            VStack {
                
                ScrollView {
                    ForEach(previewDataTest.results.indices, id: \.self) { index in
                        NavigationLink {
                            MovieDetails(movie: previewDataTest.results[index])
                        }label: {
                            MovieCardView(movie: previewDataTest.results[index], index: index)
                        }
                        .tint(.black)
                        
                    }
                    
                }
                .padding(.horizontal)
                .scrollIndicators(.hidden)
                
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
