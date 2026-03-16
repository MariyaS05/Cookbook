//
//  RecipeAPIEndpoint.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//

enum RecipeAPIEndpoint: APIEndpointProtocol {
    case byCategory(String)
    case countries
    case categories
    case byLetter(String)
    case byId(String)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .byLetter, .byCategory: return "/api/json/v1/1/search.php"
        case .countries, .categories: return "/api/json/v1/1/list.php"
        case .byId: return "/api/json/v1/1/lookup.php"
        }
    }
    
    var baseURL: String { "https://www.themealdb.com" }
    
    var headers: [String : String] { [ : ] }
    
    var urlParams: [String : any CustomStringConvertible] {
        switch self {
        case .byCategory(let category):
            return ["c": category]
        case .countries:
            return ["a": "list"]
        case .categories:
            return ["c": "list"]
        case .byLetter(let letter):
            return ["f": letter]
        case .byId(let id):
            return ["i": id]
        }
    }
    
    var body: HTTPBody? {
        return nil
    }
}
