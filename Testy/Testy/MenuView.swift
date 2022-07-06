//
//  ContentView.swift
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

struct MenuView: View {

    @State var showingSheet = false
    
    @StateObject var recipeViewModel = RecipesViewModel()
    
    var body: some View {
        TabView {
            SearchRecipeView(recipesViewModel: recipeViewModel)
                .tabItem {
                    Label("all", systemImage: "magnifyingglass")
                }
            
            FavoriteRecipesView(recipesViewModel: recipeViewModel)
                .tabItem {
                    Label("favorites", systemImage: "heart")
                }
        }
        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
