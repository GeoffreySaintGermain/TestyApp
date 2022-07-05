//
//  Recipe.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import SwiftUI

struct Recipe: Codable, Hashable, Identifiable {

    var id: Int
    var name: String
    var description: String
    var thumbnail_url: URL
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct TastyResponseRecipe: Codable {
    var count: Int
    var results: [Recipe]    
}
