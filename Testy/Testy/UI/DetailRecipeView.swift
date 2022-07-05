//
//  DetailRecipeView.swift
//  Testy
//
//  Created by Saint Germain on 05/07/2022.
//

import Foundation
import SwiftUI

struct DetailRecipeView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    @State var recipe: Recipe
    
    @State var showingShareSheet = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: recipe.thumbnail_url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .layoutPriority(-1)
                } placeholder: {
                    ProgressView()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                                
                HStack {
                    Spacer()
                    Text(recipe.name)
                        .font(.title)
                    Spacer()
                }
                .padding(.top, testyPaddingS)
                
                Divider()
                
                HStack {
                    Button {
                        showingShareSheet = true
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Button {
                        if recipesViewModel.favorites.contains(recipe) {
                            recipesViewModel.removeFromFavorite(recipe)
                        } else {
                            recipesViewModel.addToFavorite(recipe)
                        }
                    } label: {
                        recipesViewModel.favorites.contains(recipe) ? Label("Favorite", systemImage: "heart.fill") : Label("Favorite", systemImage: "heart")
                    }
                    .buttonStyle(.plain)
                }
                .padding([.leading, .trailing], testyPaddingXXL)
                
                Divider()
                                
                Text(recipe.description)
                    .font(.footnote)
                    .padding(testyPaddingS)
                                                                
                Spacer()
            }
            .sheet(isPresented: $showingShareSheet, content: { ActivityViewController(itemsToShare: [recipe.description]) })
        }
    }
}
