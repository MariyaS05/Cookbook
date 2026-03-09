//
//  RecipeListResponseDTO.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//

import Foundation

struct RecipeListResponseDTO: Decodable {
    let meals: [RecipeDTO]
}

struct RecipeDTO: Decodable {
    let idMeal: String
    let strMeal: String
    let strCategory: String?
    let strArea: String?
    let strMealThumb: String?
    let strInstructions: String?
    let strYoutube: String?
    let strSource: String?
}

extension RecipeDTO {
    func toDomain() -> Recipe {
        Recipe(
            id: idMeal,
            name: strMeal,
            category: strCategory,
            area: strArea,
            thumbnailURL: strMealThumb.flatMap { URL(string: $0) },
            instructions: strInstructions,
            youtubeURL: strYoutube.flatMap { URL(string: $0) },
            sourceURL: strSource.flatMap { URL(string: $0) }
        )
    }
}

extension RecipeListResponseDTO {
    func toDomain() -> [Recipe] {
        meals.map { $0.toDomain() }
    }
}
