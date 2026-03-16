//
//  RecipeView.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//

import SwiftUI

struct RecipeView: View {
    @StateObject var viewModel = RecipeViewModel()
    var body: some View {
        VStack(spacing: 0) {
            headerView
                .padding(.bottom, Layout.defaultSpacing)
            
            categoryView
            
            switch viewModel.state.loadingState {
            case .loading:
                ProgressView()
                    .progressStyle()
            case .loaded:
                recipesView
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(.hexFDF6EC)
    }
    
    private var categoryView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: Layout.categorySpacing) {
                ForEach(viewModel.state.categories, id: \.id) { category in
                    Text(category.name ?? "")
                        .font(.playfairDisplay(.medium, 14))
                        .foregroundStyle(.appBlack)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 8)
                        .overlay(
                            Capsule()
                                .stroke(.hexC2714F70, lineWidth: 1)
                        )
                }
            }
        }
        .contentMargins(.horizontal, Layout.defaultSpacing)
        .scrollIndicators(.hidden)
    }
    
    private var recipesView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Layout.gridSpacing) {
                ForEach(viewModel.state.recipes, id: \.id) { recipe in
                    Button {
                        viewModel.presentDetailRecipeView(recipe.id)
                    } label: {
                        RecipeCardView(recipe: recipe)
                    }
                }
            }
        }
        .refreshable {
            viewModel.refreshRecipeList()
        }
        .contentMargins(.vertical, Layout.defaultSpacing)
        .scrollIndicators(.hidden)
        .padding(.horizontal, Layout.defaultSpacing)
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: Layout.headerSpacing) {
            Text(.recipeMainTitle)
                .font(.playfairDisplay(.bold, 30))
            
            Text(.recipeMainSubtitle)
                .font(.playfairDisplay(.medium, 20))
        }
        
        .foregroundStyle(.appBlack)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background {
            Color.hexC2714F
                .ignoresSafeArea()
        }
    }
    
    private enum Layout {
        static let gridSpacing: CGFloat = 12
        static let categorySpacing: CGFloat = 13
        static let headerSpacing: CGFloat = 10
        static let defaultSpacing: CGFloat = 16
    }
}

#Preview {
    RecipeView()
}
