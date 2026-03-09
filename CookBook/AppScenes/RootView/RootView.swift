//
//  RootView.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//

import SwiftUI
import Factory

struct RootView: View {
    
    @InjectedObject(\.router)
    private var router
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            createTabView()
        }
    }
    
    func createTabView() -> some View {
        TabView {
            Tab("Recipe", systemImage: "book.pages") {
                RecipeView()
            }

            
            Tab("Favorites", systemImage: "heart.fill") {
                FavouriteView()
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
        .tint(.hexC2714F)
    }
}

#Preview {
    RootView()
}
