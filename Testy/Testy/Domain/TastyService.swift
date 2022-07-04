//
//  TastyService.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import Combine

protocol TastyServiceProtocol {
    func recipeList(from offset: Int, size: Int, tags: String?, q: String?, completion: @escaping (Result<TastyResponseRecipe, Error>) -> Void)
}

public class TastyService: TastyServiceProtocol {

    private let repository: TastyRepository
    
    public init(tastyRepository repository: TastyRepository) {
        self.repository = repository
    }
    
    // MARK: Standard
    func recipeList(from offset: Int, size: Int, tags: String? = nil, q: String? = nil, completion: @escaping (Result<TastyResponseRecipe, Error>) -> Void){
        return repository.recipeList(from: offset, size: size, tags: tags, q: q, completion: { response in
            switch response {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
}
