//
//  SearchRecipesViewModel.swift
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

/// Search and Display a simplified list of favorites recipes
class SearchRecipesViewModel: ObservableObject {
    
    // MARK: Properties
    
    /// Searched recipes
    @Published var recipies: TastyResponseRecipe = TastyResponseRecipe(count: 0, results: [])
    
    /// True when calling Tasty API
    @Published var loading = false
    
    /// Service for Tasty API
    let tastyService: TastyService
    
    /// Cancellable for publisher
    private var cancellables: Set<AnyCancellable> = []
        
    // MARK: Init
    
    /// Initialise TastyService
    init() {
        tastyService = TastyService()
    }
    
    // MARK: Search functions
    
    /// Search a recipe
    ///
    /// - input:  parameter for related recipe
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
    
    /// Load more result for a recipe
    ///
    /// - input:  parameter for related recipe
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
}
