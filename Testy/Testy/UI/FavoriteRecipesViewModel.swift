//
//  FavoriteRecipesViewModel.swift
//  Testy
//
//  Created by Saint Germain on 06/07/2022.
//

import Foundation

class FavoriteRecipesViewModel: ObservableObject {
    
    @Published var favorites: [Recipe] = FileReader.readInFile(type: [Recipe].self, file: favoriteJsonFile) ?? []
        
    init() {}
    
    func refreshFavorites() {
        favorites = FileReader.readInFile(type: [Recipe].self, file: favoriteJsonFile) ?? []
    }
}
