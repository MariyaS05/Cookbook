//
//  DetailRecipeViewModel.swift
//  CookBook
//
//  Created by Govorushko Mariya on 10.03.26.
//

import Combine
import Factory

final class DetailRecipeViewModel: ViewModel {
    
    @Injected(\.recipeService)
    private var recipeService
    
    @Injected(\.router)
    private var router
    
    @Published
    var viewState: LoadingState = .loading
    
    private var id: String
    
    init(id: String) {
        self.id = id
        super.init()
        
        initialSetup()
    }
    
    private func initialSetup() {
        Task {
            let recipeResult = await recipeService.fetchById(id)
            await MainActor.run {
                switch recipeResult {
                case .success(let recipe):
                    viewState = .loaded(.init(recipe: recipe))
                case .failure(let error):
                    router.presentAlert(error)
                }
            }
        }
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
