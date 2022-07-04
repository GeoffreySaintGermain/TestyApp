//
//  TastyRepository.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import Combine

public enum TastyError: Int, Error {
    case noNetwork
    case serviceNotAvailable = 404 // http: 404
}

public class TastyRepository {
    
    let tastyController: TastyController
    
    init(tastyController: TastyController) {
        self.tastyController = tastyController
    }
    
    func recipeList(from offset: Int, size: Int, tags: String?, q: String?, completion: @escaping (Result<TastyResponseRecipe, Error>) -> Void)  {
        return tastyController.recipeList(from: offset, size: size, tags: tags, q: q, completion: { response in
            switch response {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
}
