//
//  ContentView.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AllRecipesView(allRecipesViewModel: AllRecipesViewModel())
                .tabItem {
                    Label("All", systemImage: "list.bullet")
                }
            
            Text("Favorite Recipes")
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
