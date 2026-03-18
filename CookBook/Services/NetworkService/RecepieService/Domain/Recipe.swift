//
//  Recipe.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//
import Foundation

struct Ingredient: Hashable {
    let name: String
    let measure: String
}


struct Recipe {
    let id: String
    let name: String
    let category: String?
    let area: String?
    let thumbnailURL: URL?
    let instructions: String?
    let youtubeURL: URL?
    let sourceURL: URL?
    let ingredients: [Ingredient]
}

struct RecipeFullInfo: Identifiable, Hashable {
    let id: String
    let name: String
    let category: String?
    let area: String?
    let thumbnailURL: URL?
    let instructions: String?
    let youtubeURL: URL?
    let sourceURL: URL?
}


extension Recipe {
    static let mockRecipe1: Recipe = .init(
        id: "1",
        name: "Mock Recipe",
        category: "Mock category",
        area: "Mock area",
        thumbnailURL: URL(string:"https://www.themealdb.com/images/media/meals/qwrtut1468418027.jpg"),
        instructions: nil,
        youtubeURL: nil,
        sourceURL: nil,
        ingredients: [Ingredient(name: "", measure: "")]
    )
    
    static let mockRecipe2: Recipe = .init(
        id: "2",
        name: "Mock Recipe",
        category: "Mock category",
        area: "Mock area",
        thumbnailURL: URL(string:"https://www.themealdb.com/images/media/meals/qwrtut1468418027.jpg"),
        instructions: nil,
        youtubeURL: nil,
        sourceURL: nil,
        ingredients: [Ingredient(name: "", measure: "")]
    )
    
    static let mockRecipeList: [Recipe] = [mockRecipe1, mockRecipe2]
}

extension Recipe: Hashable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
}
