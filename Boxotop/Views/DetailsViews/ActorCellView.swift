//
//  ActorCellView.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import SwiftUI

struct ActorCellView: View {
    let person: Cast
    @ObservedObject var actorImageViewModel = ActorImagesViewModel()
    var body: some View {
        VStack {
            Text(person.name)
            Text("\(person.popularity)")
        }
    }
}

struct ActorCellView_Previews: PreviewProvider {
    static var previews: some View {
        ActorCellView(person: previewCastingResponse.cast[2])
    }
}
