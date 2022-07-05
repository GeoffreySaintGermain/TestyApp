//
//  RecipesView.swift
//  Testy
//
//  Created by Saint Germain on 05/07/2022.
//

import SwiftUI

struct RecipesView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    let recipes: [Recipe]
    
    @State var selectedRecipe: Recipe? = nil
        
    var body: some View {
        GeometryReader { reader in
            List {
                ForEach(recipesViewModel.favorites, id: \.self) { recipe in
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
                        .frame(width: reader.size.width - (testyPaddingM * 2), height: 200)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                    }
                    .padding(testyPaddingM)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .padding([.top, .bottom], testyPaddingM)
            }
            .sheet(item: $selectedRecipe, content: { recipe in
                DetailRecipeView(recipesViewModel: recipesViewModel, recipe: recipe)
                
            })
            .listStyle(PlainListStyle())
        }
    }
}
