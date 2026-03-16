//
//  View+Extensions.swift
//  CookBook
//
//  Created by Govorushko Mariya on 10.03.26.
//

import SwiftUI

extension View {
    func progressStyle() -> some View {
        modifier(ProgressViewModifier())
    }
}

