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
        GeometryReader { reader in
            VStack {
                Text("New recipies")
                                
                switch recipesViewModel.recipies {
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
                                            Color.gray.opacity(0.9)
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
            }
        }
        .onAppear {
            recipesViewModel.fetchRecipies()
        }
    }
}

struct AllRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        AllRecipesView(recipesViewModel: RecipesViewModel())
    }
}
