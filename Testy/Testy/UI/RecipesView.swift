//
//  RecipesView.swift
//  Testy
//
//  Copyright 2022 Geoffrey Saint-Germain
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import SwiftUI

struct RecipesView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    let recipes: [Recipe]
    
    @State var selectedRecipe: Recipe?
    
    var body: some View {
        GeometryReader { reader in
            List {
                ForEach(recipes, id: \.self) { recipe in
                    RecipeRowView(recipesViewModel: recipesViewModel, recipe: recipe, selectedRecipe: $selectedRecipe, reader: reader)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .padding([.top, .bottom], testyPaddingM)
            }
            .sheet(item: $selectedRecipe, content: { recipe in
                DetailRecipeView(recipesViewModel: recipesViewModel, recipe: recipe)
                
            })
            .listStyle(PlainListStyle())
        }
    }
}

struct RecipeRowView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    let recipe: Recipe
    
    @Binding var selectedRecipe: Recipe?
    let reader: GeometryProxy
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                AsyncImage(url: recipe.thumbnail_url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .layoutPriority(-1)
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text(recipe.name)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(testyPaddingS)
                        .background(.regularMaterial)
                }
            }
            .onTapGesture {
                selectedRecipe = recipe
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(width: reader.size.width - (testyPaddingM * 2), height: 200)
            .clipped()
            .aspectRatio(1, contentMode: .fit)
        }
        .padding(testyPaddingM)
    }
}
