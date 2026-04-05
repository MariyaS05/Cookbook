//
//  RecipeStoreService.swift
//  CookBook
//

import SwiftData
import Combine
import Factory

extension Container {
    var recipeStoreService: Factory<RecipeStoreServiceProtocol> {
        self { @MainActor in
            let container = try? ModelContext(
                ModelContainer(
                    for: StoredRecipeModel.self
                )
            )
            return RecipeStoreService(modelContext: container)
        }
        .singleton
    }
}
protocol RecipeStoreServiceProtocol {
    var recipeStoredData: AnyPublisher<[StoredRecipeModel], Never> { get }
    func fetchStoredRecipes()
    
    @MainActor
    func toggleStoreRecipe(_ recipe: Recipe) throws
    func checkIsStored(recipe: Recipe) -> Bool
}


final class RecipeStoreService: RecipeStoreServiceProtocol {
    
    private var recipeStoredDataPublisher: CurrentValueSubject<[StoredRecipeModel], Never> = .init([])
    private var modelContext: ModelContext?
    var recipeStoredData: AnyPublisher<[StoredRecipeModel], Never> {
        recipeStoredDataPublisher.eraseToAnyPublisher()
    }
    
    init(modelContext: ModelContext?) {
           self.modelContext = modelContext
           self.recipeStoredDataPublisher = .init([])
       }
    
    func fetchStoredRecipes() {
        let recipes = fetchStored()
        recipeStoredDataPublisher.send(recipes)
    }
    
    func checkIsStored(recipe: Recipe) -> Bool {
        let recipes = fetchStored()
        return recipes.first(where: { $0.recipeId == recipe.id }) != nil
    }
    
    func toggleStoreRecipe(_ recipe: Recipe) throws {
           let isStored = checkIsStored(recipe: recipe)
           
           if isStored {
               try removeRecipe(recipe)
           } else {
               try saveRecipe(recipe)
           }
       }
}

private extension RecipeStoreService {
    func fetchStored() -> [StoredRecipeModel] {
        let fetchDescriptor = FetchDescriptor<StoredRecipeModel>()
        
        guard let recipes = try? modelContext?.fetch(fetchDescriptor) else { return  [] }
        return recipes
    }
    
    func saveRecipe(_ recipe: Recipe) throws {
        let storeModel = StoredRecipeModel(from: recipe)
        modelContext?.insert(storeModel)
        
        do {
            try modelContext?.save()
            fetchStoredRecipes()
        } catch {
            throw error
        }
    }
    
    func removeRecipe(_ recipe: Recipe) throws {
        let recipes = fetchStored()
        guard let stored = recipes.first(where: { $0.recipeId == recipe.id }) else { return }
        modelContext?.delete(stored)
       
        do {
            try modelContext?.save()
            fetchStoredRecipes()
        } catch {
            throw error
        }
    }
}

