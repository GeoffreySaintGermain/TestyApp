//
//  SearchRecipeview.swift
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

struct SearchRecipeView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    
    @State private var selectedRecipe: Recipe?
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                VStack {
                    SearchBarView(recipeViewModel: recipesViewModel, searchText: $searchText, searching: $searching)
                    
                    Divider()
                    
                    RecipesDetailListView(recipesViewModel: recipesViewModel,
                                          recipes: recipesViewModel.recipies.results,
                                          searchText: $searchText)
                }                
                Spacer()
            }
            .navigationTitle("discoverNewRecipes")
            .navigationBarTitleDisplayMode(.inline)
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
                TextField("search...", text: $searchText) { startedEditing in
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
        .frame(height: 20)
        .cornerRadius(13)
        .padding()
    }
}

struct RecipesDetailListView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    let recipes: [Recipe]
    @Binding var searchText: String
    
    @State var selectedRecipe: Recipe?
           
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                LazyVGrid(columns: columns, spacing: testyPaddingS) {
                    ForEach(recipes, id: \.self) { recipe in
                        RecipeRowView(recipesViewModel: recipesViewModel, recipe: recipe, selectedRecipe: $selectedRecipe, reader: reader)
                            .onAppear {
                                if recipe == recipes.last {
                                    recipesViewModel.loadMoreRecipe(input: searchText)
                                }
                            }                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.top, testyPaddingS)
                    .padding([.leading, .trailing], testyPaddingM)
                }
                
                if recipesViewModel.loading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .sheet(item: $selectedRecipe, content: { recipe in
                DetailRecipeView(recipesViewModel: recipesViewModel, recipe: recipe)
                
            })
            .listStyle(PlainListStyle())
        }
    }
}

struct SearchRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecipeView(recipesViewModel: RecipesViewModel())
    }
}
