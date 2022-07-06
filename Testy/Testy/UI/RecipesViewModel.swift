//
//  RecipeViewModel.swift
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

import Combine
import Foundation
import SwiftUI

class RecipesViewModel: ObservableObject {
    
    let tastyService: TastyService
    
    @Published var recipies: TastyResponseRecipe = TastyResponseRecipe(count: 0, results: [])
    @Published var favorites: [Recipe] = FileReader.readInFile(type: [Recipe].self, file: favoriteJsonFile) ?? []
    
    @Published var loading = false
    
    private var cancellables: Set<AnyCancellable> = []
        
    init() {
        tastyService = TastyService()
//        searchRecipe()
    }
    
    // MARK: Search functions
    
    func searchRecipe(input: String? = nil) {
        loading = true
        
        tastyService.recipeList(from: 0, size: 20, q: input)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.loading = false
                        break
                }
                print("Completion \(completion)")
            } receiveValue: { response in
                self.recipies = response
                self.loading = false
            }.store(in: &cancellables)
    }
    
    func loadMoreRecipe(input: String? = nil) {
        loading = true
        
        guard recipies.results.count < recipies.count else {
            loading = false
            return
        }
        
        tastyService.recipeList(from: recipies.results.count, size: 20, q: input)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.loading = false
                        break
                }
                print("Completion \(completion)")
            } receiveValue: { response in
                self.recipies.results += response.results
                self.recipies.count = response.count
                self.loading = false
            }.store(in: &cancellables)
    }
    
    // MARK: Favorites functions
    
    func addToFavorite(_ recipe: Recipe) {
        favorites.append(recipe)
        writeFavoritesInFile(favorites)
    }
    
    func removeFromFavorite(_ recipe: Recipe) {
        guard let index = favorites.firstIndex(of: recipe) else {
            return
        }
        favorites.remove(at: index)
        writeFavoritesInFile(favorites)
    }
    
    private func writeFavoritesInFile(_ recipes: [Recipe]) {
        FileReader.writeInFile(data: recipes, file: favoriteJsonFile)
    }
}
