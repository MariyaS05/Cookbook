//
//  RouterService.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//

import Factory
import SwiftUI
import MessageUI
import Combine

extension Container {
    var router: Factory<RouterService> {
        Factory(self) { @MainActor in RouterService()}
            .singleton
    }
}

@MainActor
final class RouterService: ObservableObject {
    @Published var navigationPath: NavigationPath = .init()
    @Published var sheetScreen: SheetScreen?
    @Published var networkError: NetworkError?
    
    func push(_ screen: Screen) {
        navigationPath.append(screen)
    }
 
    func pop() {
        guard !navigationPath.isEmpty else { return }
        
        navigationPath.removeLast()
    }

    func popToRoot() {
        navigationPath = .init()
    }
    
    func presentAlert(_ error: NetworkError) {
        networkError = error
    }
    
    func presentSheet(_ sheet: SheetScreen) {
        sheetScreen = sheet
    }
    
    func dissmissSheet() {
        sheetScreen = nil
    }
    
    
    func openURL(_ url: String?) {
        guard let url = URL(string: url ?? "") else { return }
        UIApplication.shared.open(url)
    }
}


extension RouterService {
    
    enum Screen: Identifiable, Hashable {
        case detailRecipe(id: String)
        var id: String {
            switch self {
            case .detailRecipe(let id):
                return "detailRecipe"
            }
        }
    }
    enum SheetScreen: Identifiable, Equatable {
        case countryList
        
        var id: String {
            switch self {
            case .countryList:
                return "countryList"
            }
        }
    }
}
