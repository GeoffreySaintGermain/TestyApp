//
//  DetailRecipeViewModel.swift
//  Testy
//
//  Created by Saint Germain on 06/07/2022.
//

import Foundation

/// ViewModel reading and writing favorites recipes
class DetailRecipeViewModel: ObservableObject {
    
    // MARK: Properties
    
    /// List of favorites recipes, contained in a json file
    @Published var favorites: [Recipe] = FileReader.readInFile(type: [Recipe].self, file: favoriteJsonFile) ?? []
        
    // MARK: Init
    
    init() {}
    
    // MARK: Favorites functions
    
    /// Add Or Remove a favorite recipe
    func addOrRemoveFavoriteRecipe(_ recipe: Recipe) {
        if favorites.contains(recipe) {
            removeFromFavorite(recipe)
        } else {
            addToFavorite(recipe)
        }
    }
    
    /// Add new recipe
    ///     and write current favorites in a json file
    private func addToFavorite(_ recipe: Recipe) {
        favorites.append(recipe)
        writeFavoritesInFile(favorites)
    }
    
    /// Remove a recipe
    ///     and write current favorites in a json file
    private func removeFromFavorite(_ recipe: Recipe) {
        guard let index = favorites.firstIndex(of: recipe) else {
            return
        }
        favorites.remove(at: index)
        writeFavoritesInFile(favorites)
    }
    
    /// Write favorites recipes in a json file
    private func writeFavoritesInFile(_ recipes: [Recipe]) {
        FileReader.writeInFile(data: recipes, file: favoriteJsonFile)
    }
}
