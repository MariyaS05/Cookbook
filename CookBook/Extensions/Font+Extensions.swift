//
//  Font+Extensions.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//
import SwiftUI

extension Font {
    static func customFont(_ font: CustomFont, _ size: CGFloat) -> Font {
        custom(font.name, size: size)
    }
    
    static func playfairDisplay(_ font: PlayfairDisplay, _ size: CGFloat) -> Font {
        custom(font.name, size: size)
    }
}

protocol CustomFont {
    var name: String { get }
}

enum PlayfairDisplay: CustomFont {
    case regular
    case medium
    case bold
    
    var name: String {
        switch self {
        case .regular:
            return "PlayfairDisplay-Regular"
        case .medium:
            return "PlayfairDisplay-Medium"
        case .bold:
            return "PlayfairDisplay-Bold"
        }
    }
}
