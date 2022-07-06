//
//  FavoriteRecipesViewModel.swift
//  Testy
//
//  Created by Saint Germain on 06/07/2022.
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

/// ViewModel reading favorites recipes
class FavoriteRecipesViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var favorites: [Recipe] = FileReader.readInFile(type: [Recipe].self, file: favoriteJsonFile) ?? []
        
    // MARK: Init
    
    init() {}
    
    // MARK: Functions
    
    func refreshFavorites() {
        favorites = FileReader.readInFile(type: [Recipe].self, file: favoriteJsonFile) ?? []
    }
}
