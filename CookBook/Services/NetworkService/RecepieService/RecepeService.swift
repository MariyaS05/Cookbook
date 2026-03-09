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
        async let resultA: Result<RecipeListResponseDTO, NetworkError> = await sendRequest(RecipeAPIEndpoint.byLetter("a"))
        async let resultB: Result<RecipeListResponseDTO, NetworkError> = await sendRequest(RecipeAPIEndpoint.byLetter("b"))
        async let resultC: Result<RecipeListResponseDTO, NetworkError> = await sendRequest(RecipeAPIEndpoint.byLetter("c"))
        
        let generalResult = await [resultA, resultB, resultC ]
        
        let meals = generalResult
            .compactMap { try? $0.get()}
            .flatMap({ $0.toDomain()})
        
        guard !meals.isEmpty else { return .failure(.unknown)}
        
        return .success(Array(meals.prefix(20)))
    }
}
