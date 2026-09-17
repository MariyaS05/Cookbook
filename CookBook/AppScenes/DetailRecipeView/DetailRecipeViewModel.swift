//
//  DetailRecipeViewModel.swift
//  CookBook
//
//  Created by Govorushko Mariya on 10.03.26.
//

import Combine
import Factory
import Foundation

final class DetailRecipeViewModel: ViewModel {
    
    @Injected(\.recipeService)
    private var recipeService
    
    @Injected(\.router)
    private var router
    
    @Injected(\.recipeStoreService)
    private var recipeStoreService
    
    @Published
    var viewState: LoadingState = .loading
    
    @Published
    var isFavorite: Bool = false
    
    private var id: String
    
    init(id: String) {
        self.id = id
        super.init()
        
        initialSetup()
    }
    
    func toggleFavorite() {
        switch viewState {
        case .loading:
            break
        case .loaded(let viewState):
            guard let recipe = viewState.recipe else { return }
            do {
                try recipeStoreService.toggleStoreRecipe(recipe)
            } catch {
                router.presentAlert(.unknown)
            }
        }
    }
}

private extension DetailRecipeViewModel {
    func initialSetup() {
        Task {
            let recipeResult = await recipeService.fetchById(id)
            await MainActor.run {
                switch recipeResult {
                case .success(let recipe):
                    viewState = .loaded(.init(recipe: recipe))
                    bindIsFavorite()
                case .failure(let error):
                    router.presentAlert(error)
                }
            }
        }
    }
    
    func bindIsFavorite() {
        recipeStoreService.recipeStoredData
            .filter({ !$0.isEmpty })
            .sink { [weak self] _ in
                
                guard let self = self,
                      case .loaded(let viewState) = self.viewState,
                      let recipe = viewState.recipe else { return }
                
                isFavorite = recipeStoreService.checkIsStored(recipe: recipe)
            }
            .store(in: &cancellable)
    }
}

extension DetailRecipeViewModel {
    struct ViewState {
        let recipe: Recipe?
    }
    
    enum LoadingState {
        case loading
        case loaded(ViewState)
    }
}
