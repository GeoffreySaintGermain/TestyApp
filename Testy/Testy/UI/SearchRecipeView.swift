//
//  SearchRecipeview.swift
//  Testy
//
//  Created by Saint Germain on 05/07/2022.
//

import SwiftUI

struct SearchRecipeView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    
    @State private var selectedRecipe: Recipe? = nil
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                VStack {
                    SearchBarView(recipeViewModel: recipesViewModel, searchText: $searchText, searching: $searching)
                    
                    Divider()
                    
                    RecipesView(recipesViewModel: recipesViewModel, recipes: recipesViewModel.searchRecipies.results)                
                }                
                Spacer()
            }
            .navigationTitle("Search a recipe")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SearchBarView: View {
    
    @ObservedObject var recipeViewModel: RecipesViewModel
    
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightGray"))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ...", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                        recipeViewModel.searchRecipe(input: searchText)
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(.leading, testyPaddingM)
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}

struct SearchRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecipeView(recipesViewModel: RecipesViewModel())
    }
}
