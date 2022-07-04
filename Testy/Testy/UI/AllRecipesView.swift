//
//  AllRecipesView.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import Foundation
import SwiftUI

struct AllRecipesView: View {
    
    @StateObject var allRecipesViewModel: AllRecipesViewModel
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                Text("All your recipies")
                
                switch allRecipesViewModel.recipies {
                    case .success(let response):
                        ForEach(response.results, id: \.self) { recipe in
                            VStack(alignment: .center) {
                                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                                    AsyncImage(url: recipe.thumbnail_url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .layoutPriority(-1)
                                    } placeholder: {
                                        Color.red.opacity(1)
                                    }
                                                                    
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        
                                        Text(recipe.name)
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .padding(testyPaddingS)
                                            .background(.regularMaterial)
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(width: reader.size.width - testyPaddingM, height: 200)
                                .clipped()
                                .aspectRatio(1, contentMode: .fit)
                            }
                        }
                        .padding([.top, .bottom], testyPaddingM)
                    case .failure(_):
                        Text("Error while fetching data :(")
                }
            }
        }
        .onAppear {
            allRecipesViewModel.fetchRecipies()
        }
    }
}

struct AllRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        AllRecipesView(allRecipesViewModel: AllRecipesViewModel())
    }
}
