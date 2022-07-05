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
                    
                    switch recipesViewModel.searchRecipies {
                        case .success(let response):
                            List {
                                ForEach(response.results, id: \.self) { recipe in
                                    VStack(alignment: .center) {
                                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                                            AsyncImage(url: recipe.thumbnail_url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .layoutPriority(-1)
                                            } placeholder: {
                                                ProgressView()
                                            }

                                            VStack(alignment: .leading) {
                                                Spacer()

                                                Text(recipe.name)
                                                    .frame(minWidth: 0, maxWidth: .infinity)
                                                    .padding(testyPaddingS)
                                                    .background(.regularMaterial)
                                            }
                                        }
                                        .onTapGesture {
                                            selectedRecipe = recipe
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .frame(width: reader.size.width - testyPaddingM, height: 200)
                                        .clipped()
                                        .aspectRatio(1, contentMode: .fit)
                                    }
                                }
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .padding([.top, .bottom], testyPaddingM)
                            }
                            .sheet(item: $selectedRecipe, content: { recipe in
                                DetailRecipeView(recipesViewModel: recipesViewModel, recipe: recipe)
                                
                            })
                            .listStyle(PlainListStyle())
                        case .failure(_):
                            Text("Error while fetching data :(")
                    }
                    
                    Spacer()
                }
                .navigationTitle("Search a recipe")
                .navigationBarTitleDisplayMode(.large)
            }
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
