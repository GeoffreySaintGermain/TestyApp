//
//  FavoriteRecipesView.swift
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

/// Display a simplified list of favorites recipes
struct FavoriteRecipesView: View {
    
    /// ViewModel for FavoriteRecipesView
    @StateObject var recipesViewModel: FavoriteRecipesViewModel
    
    /// Display a detail Recipe when tap on it
    @State var selectedRecipe: Recipe?
    
    var body: some View {
        NavigationView {
            VStack {
                FavoritesRecipesListView(recipesViewModel: recipesViewModel)
            }
            .onAppear {
                recipesViewModel.refreshFavorites()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("myFavoritesRecipes"))
        }        
    }
}

/// List of favorites recipes
struct FavoritesRecipesListView: View {
    
    /// ViewModel for FavoriteRecipesView
    @ObservedObject var recipesViewModel: FavoriteRecipesViewModel
    
    /// Display a detail Recipe when tap on it
    @State private var selectedRecipe: Recipe?
    
    /// 2 identical columns displaying simplify recipes
    private let columns = [
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                LazyVGrid(columns: columns, spacing: testyPaddingS) {
                    ForEach(recipesViewModel.favorites, id: \.self) { recipe in
                        RecipeRowView(recipe: recipe, selectedRecipe: $selectedRecipe, reader: reader)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.top, testyPaddingS)
                    .padding([.leading, .trailing], testyPaddingM)
                }
            }
            .sheet(item: $selectedRecipe) {
                recipesViewModel.refreshFavorites()
            } content: { recipe in
                DetailRecipeView(recipesViewModel: DetailRecipeViewModel(), recipe: recipe)
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct FavoriteRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRecipesView(recipesViewModel: FavoriteRecipesViewModel())
    }
}
