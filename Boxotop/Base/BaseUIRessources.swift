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



func shadowColorOnColorScheme(colorSchemeToCheck: ColorScheme) -> Color {
    
    
    if colorSchemeToCheck == .dark {
        return .white
    }else {
        return .black
    }
    
}

