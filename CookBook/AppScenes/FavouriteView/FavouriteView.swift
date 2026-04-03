//
//  FavouriteView.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//

import SwiftUI

struct FavouriteView: View {
    @StateObject var viewModel = FavouriteViewModel()
    var body: some View {
        Group {
            switch viewModel.viewsState {
            case .loading:
                ProgressView()
                    .progressStyle()
            case .loaded(let state):
                recipesView(state.recipes)
            }
        }
        .task {
            viewModel.fetchStoredRecipes()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(.hexFDF6EC)
    }
    
    private func recipesView(_ recipes: [Recipe]) -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Layout.gridSpacing) {
                ForEach(recipes, id: \.id) { recipe in
                    Button {
                        viewModel.presentDetailRecipeView(recipe.id)
                    } label: {
                        RecipeCardView(recipe: recipe)
                    }
                }
            }
        }

        .contentMargins(.vertical, Layout.defaultSpacing)
        .scrollIndicators(.hidden)
        .padding(.horizontal, Layout.defaultSpacing)
    }
}

#Preview {
    FavouriteView()
}

extension FavouriteView {
    private enum Layout {
        static let gridSpacing: CGFloat = 12
        static let categorySpacing: CGFloat = 13
        static let headerSpacing: CGFloat = 10
        static let defaultSpacing: CGFloat = 16
    }
}
