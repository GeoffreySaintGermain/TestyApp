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

struct FavoriteRecipesView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    
    @State var selectedRecipe: Recipe?
    
    var body: some View {
        NavigationView {
            VStack {
                RecipesView(recipesViewModel: recipesViewModel, recipes: recipesViewModel.favorites)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("myFavoritesRecipes"))
        }        
    }
}

struct FavoriteRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRecipesView(recipesViewModel: RecipesViewModel())
    }
}
