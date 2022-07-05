//
//  AllRecipeViewModel.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import Foundation

class RecipesViewModel: ObservableObject {
    var tastyService: TastyService
    
    @Published var recipies: Result<TastyResponseRecipe, Error> = .success(TastyResponseRecipe(count: 0, results: []))
    @Published var favorites: [Recipe] = []
    
    init() {
        tastyService = TastyService(tastyRepository: TastyRepository(tastyController: TastyController()))
    }
    
    func fetchRecipies() {
        tastyService.recipeList(from: 0, size: 10, completion: { response in
            self.recipies = response
        })
    }
    
    func addToFavorite(_ recipe: Recipe) {
        favorites.append(recipe)
    }
    
    func removeFromFavorite(_ recipe: Recipe) {
        if let index = favorites.firstIndex(of: recipe) {
            favorites.remove(at: index)
        }
    }
    
}
