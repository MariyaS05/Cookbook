//
//  ProgressViewModifier.swift
//  CookBook
//
//  Created by Govorushko Mariya on 10.03.26.
//
import SwiftUI
struct ProgressViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaleEffect(2)
            .tint(.hexC2714F)
            .frame(maxHeight: .infinity)
    }
}
