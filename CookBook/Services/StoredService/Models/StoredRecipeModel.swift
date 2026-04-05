//
//  StoredRecipeModel.swift
//  CookBook
//

import SwiftData
import Foundation

@Model
class StoredRecipeModel: Identifiable {
    @Attribute(.unique)
    var recipeId: String
    var name: String
    var category: String?
    var area: String?
    var thumbnailURL: URL?
    var instructions: String?
    var youtubeURL: URL?
    var sourceURL: URL?
    
    @Relationship(deleteRule: .cascade, inverse: \SavedIngredient.recipe)
    var ingredients: [SavedIngredient] = []
    
    var isFavorite: Bool = false
    var savedDate: Date = Date()
    
    init(
         recipeId: String,
         name: String,
         category: String? = nil,
         area: String? = nil,
         thumbnailURL: URL? = nil,
         instructions: String? = nil,
         youtubeURL: URL? = nil,
         sourceURL: URL? = nil,
         ingredients: [SavedIngredient] = []) {
        self.recipeId = recipeId
        self.name = name
        self.category = category
        self.area = area
        self.thumbnailURL = thumbnailURL
        self.instructions = instructions
        self.youtubeURL = youtubeURL
        self.sourceURL = sourceURL
        self.ingredients = ingredients
    }
}


@Model
final class SavedIngredient {
    var name: String
    var measure: String
    var recipe: StoredRecipeModel?
    
    init(name: String, measure: String) {
        self.name = name
        self.measure = measure
    }
}


extension StoredRecipeModel {
    convenience init(from dto: Recipe) {
        let ingredients = dto.ingredients.map {
            SavedIngredient(name: $0.name, measure: $0.measure)
        }
        
        self.init(
            recipeId: dto.id,
            name: dto.name,
            category: dto.category,
            area: dto.area,
            thumbnailURL: dto.thumbnailURL,
            instructions: dto.instructions,
            youtubeURL: dto.youtubeURL,
            sourceURL: dto.sourceURL,
            ingredients: ingredients
        )
    }
    
    func toDTO() -> Recipe {
        .init(
            id: recipeId,
            name: name,
            category: category,
            area: area,
            thumbnailURL: thumbnailURL,
            instructions: instructions,
            youtubeURL: youtubeURL,
            sourceURL: sourceURL,
            ingredients: ingredients.map({ Ingredient(name: $0.name, measure: $0.measure)})
            )
    }
}
