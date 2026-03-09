//
//  RecipeViewModel.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//

import SwiftUI
import Combine
import Factory

final class RecipeViewModel: ViewModel {
    @Injected(\.recipeService)
    private var recipeService
    
    @Published
    var state: State = .init()
    
    override init() {
        super.init()
        
        fetchRecipes()
        fetchCategories()
    }
}

extension RecipeViewModel {
    struct State {
        var recipes: [Recipe] = []
        var countries: [Country] = []
        var categories: [Category] = []
    }
}
private extension RecipeViewModel {
    func fetchRecipes() {
        Task {
            let initialRecipesResult = await recipeService.fetchInitials()
            switch initialRecipesResult {
            case .success(let recipes):
                await MainActor.run {
                    self.state.recipes = recipes
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCategories() {
        Task {
            let initialCategoryResult = await recipeService.fetchCategories()
            switch initialCategoryResult {
            case .success(let categories):
                await MainActor.run {
                    self.state.categories = categories
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
