//
//  Recipe.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//
import Foundation

struct Recipe: Identifiable, Hashable {
    let id: String
    let name: String
    let category: String?
    let area: String?
    let thumbnailURL: URL?
    let instructions: String?
    let youtubeURL: URL?
    let sourceURL: URL?
}
