//
//  DetailRecipeView.swift
//  CookBook
//
//  Created by Govorushko Mariya on 10.03.26.
//

import SwiftUI

struct DetailRecipeView: View {
    
    @StateObject var viewModel: DetailRecipeViewModel
    @State private var triggerAnimation = false
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView()
                    .progressStyle()
                
                
            case .loaded(let recipe):
                if let recipe = recipe.recipe {
                    setupLoadedViewState(recipe)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.hexFDF6EC)
    }
    
    @ViewBuilder
    private func setupLoadedViewState(_ recipe: Recipe) -> some View {
        ScrollView {
            VStack(spacing: 8) {
                RecipeImageView(recipe: recipe)
                    .stretchy()
                
                createTitleView(recipe)
                createIngredientsView(recipe)
                createInstructionView(recipe)
                    .padding()
                
                createSourceView(recipe)
            }
        }
        .overlay(alignment: .bottomTrailing ,content: {
            Button(action: {
                viewModel.toggleFavorite()
                triggerAnimation.toggle()
            }) {
                Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                    .font(.customFont(PlayfairDisplay.bold, 40))
                    .symbolEffect(.bounce.down.byLayer, options: .nonRepeating)
                    .padding(40)
                    .id(triggerAnimation)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.red.opacity(0.5), .red]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            
        })
        .contentMargins(.bottom, 30)
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func createSourceView(_ recipe: Recipe) -> some View {
        HStack {
            Image(systemName: "link")
            
            Button {
                guard let url = recipe.youtubeURL else { return }
                openURL(url)
            } label: {
                Text(.youtubeTitle)
                    .underline(true)
            }
            
            Button {
                guard let url = recipe.sourceURL else { return }
                openURL(url)
            } label: {
                Text(.sourceTitle)
                    .underline(true)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.playfairDisplay(.regular, 20))
        .foregroundStyle(.appBlack.opacity(0.6))
    }
    
    @ViewBuilder
    private func createTitleView(_ recipe: Recipe) -> some View {
        VStack(spacing: 10) {
            Text(recipe.name)
                .font(.playfairDisplay(.bold, 30))
                .foregroundStyle(.appBlack)
            
            HStack(spacing: 4) {
                if let category = recipe.category {
                    Text(category)
                        .lineLimit(1)
                }
                if let area = recipe.area {
                    Text("· \(area)")
                        .lineLimit(1)
                }
            }
        }
        .multilineTextAlignment(.center)
        .font(.playfairDisplay(.regular, 20))
        .foregroundStyle(.appBlack.opacity(0.6))
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    @ViewBuilder
    private func createIngredientsView(_ recipe: Recipe) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(.ingredients)
                .font(.playfairDisplay(.medium, 20))
                .foregroundStyle(.appBlack)
            VStack {
                ForEach(recipe.ingredients, id: \.name) { ingredient in
                    Text("-\(ingredient.name) - \(ingredient.measure)")
                        .font(.playfairDisplay(.regular, 14))
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .foregroundStyle(.appBlack)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func createInstructionView(_ recipe: Recipe) -> some View {
        VStack(spacing: 8) {
            Text(.preparationTitle)
                .font(.playfairDisplay(.medium, 20))
                .italic()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let instructions = recipe.instructions {
                Text(instructions)
                    .font(.playfairDisplay(.regular, 14))
                    .opacity(0.7)
            }
        }
        .foregroundStyle(.appBlack)
    }
}

#Preview {
    DetailRecipeView(viewModel: DetailRecipeViewModel(id: "53262"))
}


