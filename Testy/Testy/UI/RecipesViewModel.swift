//
//  AllRecipeViewModel.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import Foundation
import SwiftUI

class RecipesViewModel: ObservableObject {
    var tastyService: TastyService
    
    @Published var recipies: TastyResponseRecipe = TastyResponseRecipe(count: 0, results: [])
    @Published var searchRecipies: TastyResponseRecipe = TastyResponseRecipe(count: 0, results: [])
    @Published var favorites: [Recipe] = RecipesViewModel.readFavoritesFromFile()
    
    private static let favoriteJsonFile = "favoriteRecipes.json"
    
    init() {
        tastyService = TastyService(tastyRepository: TastyRepository(tastyController: TastyController()))
//        fetchRecipies()
    }
    
    func fetchRecipies() {
        tastyService.recipeList(from: 0, size: 10, completion: { response in
            switch response {
                case .success(let response):
                    self.recipies = response
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
    
    // MARK: Search functions
    func searchRecipe(input: String) {
        tastyService.recipeList(from: 0, size: 10, q: input, completion: { response in
            switch response {
                case .success(let response):
                    self.searchRecipies = response
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
    
    // MARK: Favorites functions
    
    func addToFavorite(_ recipe: Recipe) {
        favorites.append(recipe)
        RecipesViewModel.writeFavoritesInFile(favorites)
    }
    
    func removeFromFavorite(_ recipe: Recipe) {
        if let index = favorites.firstIndex(of: recipe) {
            favorites.remove(at: index)
            RecipesViewModel.writeFavoritesInFile(favorites)
        }
    }
    
    // MARK: Files functions
    
    private static func writeFavoritesInFile(_ recipes: [Recipe]) {
        do {
            let encodedFavorites = try JSONEncoder().encode(recipes)
            let path = FileManager.default.urls(for: .documentDirectory ,in: .userDomainMask)[0]
            let url = path.appendingPathComponent(favoriteJsonFile)
            
            try encodedFavorites.write(to: url)
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private static func readFavoritesFromFile() -> [Recipe] {
        let decoder = JSONDecoder()
        
        guard let path = FileManager.default.urls(for: .documentDirectory ,in: .userDomainMask).first else {
            print("Cannot find url from path")
            return []
        }
        
        let url = path.appendingPathComponent(favoriteJsonFile)
        
        guard let data = try? Data(contentsOf: url) else {
            print("Failed to load from bundle.")
            return []
        }        

        guard let loaded = try? decoder.decode([Recipe].self, from: data) else {
            print("Failed to decode from bundle.")
            return []
        }

        return loaded
    }
    
}
