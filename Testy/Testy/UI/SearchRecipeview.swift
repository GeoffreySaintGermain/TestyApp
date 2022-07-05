//
//  SearchRecipeview.swift
//  Testy
//
//  Created by Saint Germain on 05/07/2022.
//

import SwiftUI

struct SearchRecipeview: View {
    
    @State var searchText = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ...", text: $searchText)
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
    }
}

struct SearchRecipeview_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecipeview()
    }
}
