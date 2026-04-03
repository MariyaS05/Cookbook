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
    //MARK: - Injected
    @Injected(\.recipeService)
    private var recipeService
    
    @Injected(\.router)
    private var router
    
    //MARK: - Published
    @Published
    var state: State = .init()
    
    //MARK: - Private
    @ObservationIgnored
    private var refreshTask: Task<Void, Never>?
    
    override init() {
        super.init()
        
        fetchRecipes()
        fetchCategories()
    }
    
    @MainActor
    func presentDetailRecipeView(_ id: String) {
        router.push(.detailRecipe(id: id))
    }
    
    func refreshRecipeList() {
        fetchRecipes()
    }
}

extension RecipeViewModel {
    struct State {
        var recipes: [Recipe] = []
        var countries: [Country] = []
        var categories: [Category] = []
        var loadingState: LoadingState = .loading
    }
    
    enum LoadingState {
        case loading
        case loaded
    }
}

private extension RecipeViewModel {
    func fetchRecipes() {
        refreshTask?.cancel()
        refreshTask = Task {
            guard !Task.isCancelled else { return }
            let initialRecipesResult = await recipeService.fetchInitials()
            
            guard !Task.isCancelled else { return }
            await MainActor.run {
                switch initialRecipesResult {
                case .success(let recipes):
                    self.state.recipes = recipes
                    self.state.loadingState = .loaded
                case .failure(let error):
                    router.presentAlert(error)
                }
            }
        }
    }
    
    func fetchCategories() {
        Task {
            let initialCategoryResult = await recipeService.fetchCategories()
            await MainActor.run {
                switch initialCategoryResult {
                case .success(let categories):
                    self.state.categories = categories
                case .failure(let error):
                    router.presentAlert(error)
                }
            }
        }
    }
}
