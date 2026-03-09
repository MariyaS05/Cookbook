//
//  CountryListDTO.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//


struct CountryListDTO: Decodable {
    let meals: [CountryDTO]
}

struct CountryDTO: Decodable {
    let strArea: String
}

extension CountryDTO {
    func toDomain() -> Country {
        Country(
            id: strArea,
            name: strArea
        )
    }
}

extension CountryListDTO {
    func toDomain() -> [Country] {
        meals.map { $0.toDomain()}
    }
}
