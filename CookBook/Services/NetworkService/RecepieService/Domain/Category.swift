//
//  Category.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id: String?
    let name: String?
}

extension Category {
    static let mockCategory1: Category = .init(id: "1", name: "Test")
    static let mockCategory2: Category = .init(id: "2", name: "Beef")
    static let mockCategory3: Category = .init(id: "3", name: "Milk")
    static let mockCategory4: Category = .init(id: "4", name: "Vegan")
    static let all: Category = .init(id: "0", name: "All")
    
    static let allMockCategories: [Category] = [mockCategory1, mockCategory2, mockCategory4]
}


