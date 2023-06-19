//
//  ActorCellView.swift
//  Boxotop
//
//  Created by Romain Poyard on 19/06/2023.
//

import SwiftUI

struct ActorCellView: View {
    let person: Cast
    @StateObject var actorImageViewModel = ActorImagesViewModel()
    var body: some View {
        VStack {
            if actorImageViewModel.actorURLsImage.isEmpty == false {
                VStack {
                    if let imageURL = actorImageViewModel.actorURLsImage[0].imageURL {
                        AsyncImage(url: imageURL) { image in
                            
                            VStack {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                Text(person.name)
                                    .font(.caption)
                            }
                            .padding(.horizontal)
                            
                        } placeholder: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 100, height: 150)
                                    .foregroundColor(.gray.opacity(0.3))
                                ProgressView()
                                    .progressViewStyle(.circular)
                            }
                            .padding(.horizontal)
                        }
                        
                    }else {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                
            }
        }
        .task {
            await actorImageViewModel.loadActorURLsImage(actorID: person.id)
        }
        
    }
}

struct ActorCellView_Previews: PreviewProvider {
    static var previews: some View {
        ActorCellView(person: previewCastingResponse.cast[2])
    }
}
