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

/// TabView With 2 Views
///  - SearchRecipeView: Ask TastyApi and display a list of recipes with ou without research
///  - FavoriteRecipesView: Show a list of favorite recipes
struct MenuView: View {
    
    @State var showingSheet = false
            
    var body: some View {
        TabView {
            SearchRecipesView(recipesViewModel: SearchRecipesViewModel())
                .tabItem {
                    Label("all", systemImage: "magnifyingglass")
                }
            
            FavoriteRecipesView(recipesViewModel: FavoriteRecipesViewModel())
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
