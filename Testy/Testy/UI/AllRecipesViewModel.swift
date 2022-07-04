//
//  AllRecipeViewModel.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import Foundation

class AllRecipesViewModel: ObservableObject {
    var tastyService: TastyService
    
    @Published var recipies: Result<TastyResponseRecipe, Error> = .success(TastyResponseRecipe(count: 0, results: []))
    
    init() {
        tastyService = TastyService(tastyRepository: TastyRepository(tastyController: TastyController()))
    }
    
    func fetchRecipies() {
        tastyService.recipeList(from: 0, size: 2, completion: { response in
            self.recipies = response
        })
    }
    
}
