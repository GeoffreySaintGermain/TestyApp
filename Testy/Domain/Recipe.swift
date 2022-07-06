//
//  Recipe.swift
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

import SwiftUI

/// A recipe defined provide by Tasty
struct Recipe: Codable, Hashable, Identifiable {
    
    // MARK: Attributes

    var id: Int
    var name: String
    var description: String?
    var thumbnail_url: URL
    var instructions: [Instruction]?
    var sections: [Section]?
    
    // MARK: Functions
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// List of instructions to complete the recipe
struct Instruction: Codable, Hashable {
    var position: Int
    var display_text: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(position)
    }
}

/// A list of ingredients for the recipe
struct Section: Codable, Hashable {
    var position: Int
    var components: [Component]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(position)
    }
}

/// An Ingredient for the recipe
struct Component: Codable, Hashable {
    var raw_text: String
}

/// Response from TastyAPI with a list of recipe and the total number of similar recipe
struct TastyResponseRecipe: Codable {
    var count: Int
    var results: [Recipe]    
}
