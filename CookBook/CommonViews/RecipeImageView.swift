//
//  RecipeImageView.swift
//  CookBook
//
//  Created by Govorushko Mariya on 10.03.26.
//
import SwiftUI

struct RecipeImageView: View {
    let recipe: Recipe
    var body: some View {
        AsyncImage(url: recipe.thumbnailURL, scale: 1) { image in
            image
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .clipShape(.rect(cornerRadius: 12))
        } placeholder: {
            Image(.empty)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .clipShape(.rect(cornerRadius: 12))
        }
    }
}

