//
//  ViewModel.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//
import SwiftUI
import Combine
import Factory

class ViewModel: ObservableObject {
    @Injected(\.router)
    private var router
}
