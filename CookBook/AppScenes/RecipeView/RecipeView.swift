//
//  RecipeView.swift
//  CookBook
//
//  Created by Govorushko Mariya on 9.03.26.
//

import SwiftUI

struct RecipeView: View {
    @StateObject var viewModel = RecipeViewModel()
    var body: some View {
        VStack {
            headerView
                .frame(maxHeight: .infinity, alignment: .top)
            
            categoryView
        }
    }
    
    private var categoryView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.state.categories, id: \.id) { category in
                    Text(category.name ?? "")
                        .font(.playfairDisplay(.medium, 12))
                        .foregroundStyle(.appBlack)
                        .padding()
                        .clipShape(.capsule)
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recipe book")
                .font(.playfairDisplay(.bold, 30))
            
            Text("Your favorite recipes, all in one place")
                .font(.playfairDisplay(.medium, 20))
        }
        .foregroundStyle(.appBlack)
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            Color.hexC2714F
                .ignoresSafeArea()
        }
    }
}

#Preview {
    RecipeView()
}
