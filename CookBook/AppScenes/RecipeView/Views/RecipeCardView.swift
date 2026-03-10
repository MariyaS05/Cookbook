//
//  RecipeCardView.swift
//  CookBook
//
//  Created by Govorushko Mariya on 10.03.26.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(spacing: 8) {
            imageView
            
            Text(recipe.name)
                .font(.playfairDisplay(.medium, 16))
                .foregroundStyle(.appBlack)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            HStack(spacing: 4) {
                if let category = recipe.category {
                    Text(category)
                        .lineLimit(1)
                }
                if let area = recipe.area {
                    Text("· \(area)")
                        .lineLimit(1)
                }
            }
            .font(.playfairDisplay(.regular, 12))
            .foregroundStyle(.appBlack.opacity(0.6))
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.hexC2714F20)
        .clipShape(.rect(cornerRadius: 16))
    }
    
    private var imageView: some View {
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

#Preview {
    RecipeCardView(recipe: Recipe(id: "2", name: "sjdehjfshdjhfsjkhdfjhsdjfhjkshdsjkdhfjhsjdfhjshjhjhskjhdfjkhsjkdhf", category: "TEts", area: "Cndin", thumbnailURL: URL(string: "https://www.themealdb.com/images/media/meals/qwrtut1468418027.jpg"), instructions: "", youtubeURL: nil, sourceURL: nil))
}
