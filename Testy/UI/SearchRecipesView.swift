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

/// Search and Display a simplified list of favorites recipes
struct SearchRecipesView: View {
    
    /// ViewModel for SearchRecipesView
    @StateObject var recipesViewModel: SearchRecipesViewModel
    
    /// Display a detail view of the recipe when tapped
    @State private var selectedRecipe: Recipe?
    
    /// Containing user input for researching a particular recipe
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                VStack(spacing: 0) {
                    SearchBarView(recipeViewModel: recipesViewModel, searchText: $searchText)
                    
                    VStack(spacing: 0) {
                        Divider()
                    }
                    .padding(.top, testyPaddingS)
                    
                    RecipesDetailListView(recipesViewModel: recipesViewModel,
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
    
    /// ViewModel for SearchRecipesView
    @ObservedObject var recipeViewModel: SearchRecipesViewModel
    
    /// Containing user input for researching a particular recipe
    @Binding var searchText: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightGray"))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("search...", text: $searchText, onCommit: {
                    withAnimation {
                        recipeViewModel.searchRecipe(input: searchText)
                    }
                })                
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
    
    /// ViewModel for SearchRecipesView
    @ObservedObject var recipesViewModel: SearchRecipesViewModel
    
    /// Search in fonction of what the user typed
    @Binding var searchText: String
    
    /// Display a detail view of the recipe when tapped
    @State var selectedRecipe: Recipe?
           
    /// 2 identical columns displaying simplify recipes
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                LazyVGrid(columns: columns, spacing: testyPaddingS) {
                    ForEach(recipesViewModel.recipies.results, id: \.self) { recipe in
                        RecipeRowView(recipe: recipe, selectedRecipe: $selectedRecipe, reader: reader)
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
                } else {
                    Button {
                        if recipesViewModel.recipies.count > 0 {
                            recipesViewModel.loadMoreRecipe(input: searchText)
                        } else {
                            recipesViewModel.searchRecipe()
                        }
                    } label: {
                        Text("loadMore")
                    }
                    .buttonStyle(TestyButtonStyle())
                }
            }
            .sheet(item: $selectedRecipe, content: { recipe in
                DetailRecipeView(recipesViewModel: DetailRecipeViewModel(), recipe: recipe)
                
            })
            .listStyle(PlainListStyle())
        }
    }
}

struct SearchRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecipesView(recipesViewModel: SearchRecipesViewModel())
    }
}
