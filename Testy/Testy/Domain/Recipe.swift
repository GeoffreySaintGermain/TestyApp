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
    var instructions: [Instruction]?
    var sections: [Section]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Instruction: Codable, Hashable {
    var position: Int
    var display_text: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(position)
    }
}

struct Section: Codable, Hashable {
    var position: Int
    var components: [Component]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(position)
    }
}

struct Component: Codable, Hashable {
    var raw_text: String
}

struct TastyResponseRecipe: Codable {
    var count: Int
    var results: [Recipe]    
}
