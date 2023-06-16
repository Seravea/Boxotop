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
        VStack {
            
            ForEach(previewDataTest.results, id: \.id) { movie in
                
                Text(movie.title)
                
            }
        }
    }
}

struct BoxOfficeListView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOfficeListView()
    }
}
