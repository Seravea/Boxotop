//
//  BaseUIRessources.swift
//  Boxotop
//
//  Created by Romain Poyard on 20/06/2023.
//

import Foundation
import SwiftUI





extension Color {
    static let myGrey: Color = Color("myGrey")
    
    static let myGreen: Color = Color("myGreen")
}





func shadowColorOnColorScheme() -> Color {
    
    @Environment(\.colorScheme) var colorScheme

    if colorScheme == .dark {
        return .white
    }else {
        return .white
    }

}

