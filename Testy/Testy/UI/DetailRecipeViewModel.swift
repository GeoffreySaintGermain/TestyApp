//
//  DetailRecipeViewModel.swift
//  Testy
//
//  Created by Saint Germain on 06/07/2022.
//

import Foundation

class DetailRecipeViewModel: ObservableObject {
    
    @Published var favorites: [Recipe] = FileReader.readInFile(type: [Recipe].self, file: favoriteJsonFile) ?? []
        
    init() {}
    
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
