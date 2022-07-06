//
//  RecipeRowView.swift
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

/// Display a simplify view of a recipe
///     Used in list displaying multiple recipes
struct RecipeRowView: View {
    
    /// The recipe to display
    let recipe: Recipe
    
    /// Display a sheet when the recipe is tapped
    @Binding var selectedRecipe: Recipe?
    
    /// Proxy containing the width of the parent's view
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
                        .font(.caption)
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(testyPaddingS)
                        .background(.thickMaterial)
                }
            }
            .onTapGesture {
                selectedRecipe = recipe
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(width: (abs(reader.size.width - (testyPaddingS * 2)) / 2), height: 200)
            .clipped()
            .aspectRatio(1, contentMode: .fit)
        }
    }
}
