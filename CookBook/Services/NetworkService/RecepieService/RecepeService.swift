//
//  R.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//

import Factory


extension Container {
    var recipeService: Factory<RecipeServiceProtocol> {
        Factory(self) { @MainActor in RecipeService() }
            .singleton
    }
}

protocol RecipeServiceProtocol {
    func fetchByCategory(_ category: String) async -> Result<[Recipe], NetworkError>
    func fetchCountries() async -> Result<[Country], NetworkError>
    func fetchCategories() async -> Result<[Category], NetworkError>
    func fetchInitials() async -> Result<[Recipe], NetworkError>
    func fetchById(_ id: String) async -> Result<Recipe, NetworkError>
}


final class RecipeService: RecipeServiceProtocol, APIClientProtocol {
    func fetchByCategory(_ category: String) async -> Result<[Recipe], NetworkError> {
        let result: Result<RecipeListResponseDTO, NetworkError> = await sendRequest(RecipeAPIEndpoint.byCategory(category))
        return result.map({ $0.toDomain()})
    }
    
    func fetchCountries() async -> Result<[Country], NetworkError> {
        let result: Result<CountryListDTO, NetworkError> = await sendRequest(RecipeAPIEndpoint.countries)
        return result.map { $0.toDomain()}
    }
    
    func fetchCategories() async -> Result<[Category], NetworkError> {
        let result: Result<CategoryListDTO, NetworkError> = await sendRequest(RecipeAPIEndpoint.categories)
        return result.map { $0.toDomain() }
    }
    
    func fetchInitials() async -> Result<[Recipe], NetworkError> {
        let letters = (97...122).compactMap { UnicodeScalar($0).map { String($0) } }
        let randomLetters = Array(letters.shuffled().prefix(3))
        
        async let resultA: Result<RecipeListResponseDTO, NetworkError> = sendRequest(RecipeAPIEndpoint.byLetter(randomLetters[0]))
        async let resultB: Result<RecipeListResponseDTO, NetworkError> = sendRequest(RecipeAPIEndpoint.byLetter(randomLetters[1]))
        async let resultC: Result<RecipeListResponseDTO, NetworkError> = sendRequest(RecipeAPIEndpoint.byLetter(randomLetters[2]))
        
        let generalResult = await [resultA, resultB, resultC]
        
        let meals = generalResult
            .compactMap { try? $0.get() }
            .flatMap { $0.toDomain() }
        
        guard !meals.isEmpty else { return .failure(.unknown) }
        
        let mealsSet: Set<Recipe> = Set(meals)
        return .success(Array(mealsSet.prefix(10)))
    }
    
    func fetchById(_ id: String) async -> Result<Recipe, NetworkError> {
        let result: Result<RecipeListResponseDTO, NetworkError> = await sendRequest(RecipeAPIEndpoint.byId(id))
        return result.flatMap {
            guard let first = $0.meals.first else {
                return .failure(.unknown)
            }
            return .success(first.toDomain())
        }
    }
}
