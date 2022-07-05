//
//  FavoriteRecipesView.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import SwiftUI

struct FavoriteRecipesView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    
    @State var selectedRecipe: Recipe? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                RecipesView(recipesViewModel: recipesViewModel, recipes: recipesViewModel.favorites)
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(Text("My favorites Recipes"))
        }        
    }
}

struct FavoriteRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRecipesView(recipesViewModel: RecipesViewModel())
    }
}
