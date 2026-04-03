//
//  Country.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//
import Foundation

struct Country: Identifiable, Hashable {
    let id: String
    let name: String
}


extension Country {
    static let mockCountry1: Country = .init(id: "1", name: "France")
    static let mockCountry2: Country = .init(id: "2", name: "Spain")
    static let mockCountry3: Country = .init(id: "3", name: "Germany")
    static let mockCountry4: Country = .init(id: "4", name: "Italy")
    
    static let countryList: [Country] = [mockCountry1, mockCountry2, mockCountry3, mockCountry4]
}
