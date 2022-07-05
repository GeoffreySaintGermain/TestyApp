//
//  ContentView.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import SwiftUI

struct MenuView: View {

    @State var showingSheet = false
    
    @StateObject var recipeViewModel = RecipesViewModel()
    
    var body: some View {
        TabView {
            AllRecipesView(recipesViewModel: recipeViewModel)
                .tabItem {
                    Label("All", systemImage: "list.bullet")
                }
            
            Text("Recherche")
                .tabItem {
                    Label("Search", systemImage: "signature")
                }
            
            FavoriteRecipesView(recipesViewModel: recipeViewModel)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
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
