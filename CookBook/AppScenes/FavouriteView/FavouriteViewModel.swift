//
//  FavouriteViewModel.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//
import SwiftUI
import Combine
import Factory

final class FavouriteViewModel: ViewModel {
    
    @Injected(\.recipeStoreService)
    private var recipeStoreService
    
    @Injected(\.router)
    private var router
    
    @Published
    var viewsState: LoadingState = .loading
    
    override init() {
        super.init()
        
        bind()
    }
    
    @MainActor
    func presentDetailRecipeView(_ id: String) {
        router.push(.detailRecipe(id: id))
    }
    
    func fetchStoredRecipes() {
        recipeStoreService.fetchStoredRecipes()
    }
}

extension FavouriteViewModel {
    struct State {
        var recipes: [Recipe] = []
    }
    
    enum LoadingState {
        case loading
        case loaded(State)
    }
}

private extension FavouriteViewModel {
    func bind() {
        recipeStoreService.recipeStoredData
            .filter ({ !$0.isEmpty })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] storedRecipes in
                self?.viewsState = .loaded(.init(recipes: storedRecipes))
            }.store(in: &cancellable)
    }
}
