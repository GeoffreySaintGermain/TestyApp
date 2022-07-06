//
//  DetailRecipeView.swift
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

import Foundation
import SwiftUI

struct DetailRecipeView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    @State var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack {
                DetailHeaderView(recipesViewModel: recipesViewModel, recipe: $recipe)
                                
                Divider()
                SectionView(recipesViewModel: recipesViewModel, recipe: $recipe)
                    .padding([.leading, .trailing], testyPaddingM)
                                
                Divider()
                InstructionView(recipesViewModel: recipesViewModel, recipe: $recipe)
                    .padding([.leading, .trailing], testyPaddingM)
            }
            
        }
    }
}

struct DetailHeaderView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    @Binding var recipe: Recipe
        
    @State var showingShareSheet = false
    
    var body: some View {
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
                            
            VStack(alignment: .center) {
                Text(recipe.name)
                    .font(.title)
            }
            .padding([.leading, .trailing], testyPaddingM)
            .padding(.top, testyPaddingS)
            
            Divider()
            
            HStack {
                Button {
                    showingShareSheet = true
                } label: {
                    Label("share", systemImage: "square.and.arrow.up")
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
                    recipesViewModel.favorites.contains(recipe) ? Label("favorite", systemImage: "heart.fill") : Label("favorite", systemImage: "heart")
                }
                .buttonStyle(.plain)
            }
            .padding([.leading, .trailing], testyPaddingXXL)
            
            if !recipe.description.isEmpty {
                Divider()
                                
                HTMLStringView(recipe.description)
                    .padding(testyPaddingS)
            }
                                                                            
            Spacer()
        }
        .sheet(isPresented: $showingShareSheet, content: { ActivityViewController(itemsToShare: [recipe.description]) })
    }
}

struct SectionView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    @Binding var recipe: Recipe
        
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(recipe.sections ?? [], id: \.self) { section in
                ForEach(section.components, id: \.self) { component in
                    HStack {
                        Text(component.raw_text)
                            .font(.body)
                        Spacer()
                    }                    
                }
            }
        }
    }
}

struct InstructionView: View {
    
    @ObservedObject var recipesViewModel: RecipesViewModel
    @Binding var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(recipe.instructions ?? [], id: \.self) { instruction in
                
                Text("\(instruction.position)")
                    .font(.title2)
                Text(instruction.display_text)
                    .font(.body)
            }
        }
    }
}
