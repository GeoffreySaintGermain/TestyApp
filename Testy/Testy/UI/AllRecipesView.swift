//
//  AllRecipesView.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import Foundation
import SwiftUI

struct AllRecipesView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    @State private var selectedRecipe: Recipe? = nil
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                VStack {                    
                    RecipesView(recipesViewModel: recipesViewModel, recipes: recipesViewModel.recipies.results)                    
                }
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("Discover new Recipes")
            }
        }
    }
}

struct AllRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        AllRecipesView(recipesViewModel: RecipesViewModel())
    }
}
