//
//  MockRecipeService.swift
//  CookBook
//
//  Created by Govorushko Mariya on 18.03.26.
//

import Factory

final class MockRecipeService: RecipeServiceProtocol {
    var shouldFail: Bool = true
    
    func fetchByCategory(_ category: String) async -> Result<[Recipe], NetworkError> {
        guard !shouldFail else {
            return .failure(.serverError)
        }
        
        try? await Task.sleep(for: .seconds(3))
        
        return .success(Recipe.mockRecipeList)
    }
    
    func fetchCountries() async -> Result<[Country], NetworkError> {
        guard !shouldFail else {
            return .failure(.unknown)
        }
        
        try? await Task.sleep(for: .seconds(6))
        
        return .success(Country.countryList)
    }
    
    func fetchCategories() async -> Result<[Category], NetworkError> {
        guard !shouldFail else {
            return .failure(.unknown)
        }
        
        try? await Task.sleep(for: .seconds(6))
        
        return .success(Category.allMockCategories)
    }
    
    func fetchInitials() async -> Result<[Recipe], NetworkError> {
        guard !shouldFail else {
            return .failure(.serverError)
        }
        
        try? await Task.sleep(for: .seconds(3))
        
        return .success(Recipe.mockRecipeList)
    }
    
    func fetchById(_ id: String) async -> Result<Recipe, NetworkError> {
        guard !shouldFail else {
            return .failure(.noInternetConnection)
        }
        
        try? await Task.sleep(for: .seconds(5))
        
        return .success(.mockRecipe1)
    }
}

