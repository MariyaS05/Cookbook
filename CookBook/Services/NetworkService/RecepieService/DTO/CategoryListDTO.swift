//
//  CategoryListDTO.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//
import Foundation

struct CategoryListDTO: Decodable {
    let categories: [CategoryDTO]
    
    enum CodingKeys: String, CodingKey {
        case categories = "meals"
    }
}

struct CategoryDTO: Decodable {
    let strCategory: String?
}

extension CategoryDTO {
    func toDomain() -> Category {
        Category(
            id: strCategory,
            name: strCategory)
    }
}

extension CategoryListDTO {
    func toDomain() -> [Category] {
        categories.map{ $0.toDomain()}
    }
}
