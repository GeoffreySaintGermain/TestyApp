//
//  TastyService.swift
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

import Combine
import Foundation

/// Protocol for Tasty API
protocol TastyServiceProtocol {
    func recipeList(from offset: Int, size: Int, tags: String?, q: String?) -> AnyPublisher<TastyResponseRecipe, Error>
}

/// Request to Tasty API
public class TastyService: TastyServiceProtocol {
    
    /// Cancel publisher
    internal var cancellables: Set<AnyCancellable> = []
    
    /// Base URL of tasty API
    let baseUrl = "https://tasty.p.rapidapi.com"
    
    /// Host URI
    let rapidApiHost = "tasty.p.rapidapi.com"
    
    /// Key to call api
    let rapidApiKey = "c4620708c3msh37263e720328b1cp1317a7jsncc90dabc8d72"
    
    /// Call TastyAPI and get a list of recipe
    ///
    ///  - from: offset of the called list
    ///  - size: number of recipe returned
    ///  - tags: specific tag for recipes
    ///  - q: text related to a recipe
    func recipeList(from offset: Int, size: Int, tags: String? = nil, q: String? = nil) -> AnyPublisher<TastyResponseRecipe, Error> {
        let headers = [
            "X-RapidAPI-Key": rapidApiKey,
            "X-RapidAPI-Host": rapidApiHost
        ]

        var url = "\(baseUrl)/recipes/list?from=\(offset)&size=\(size)"
        if let q = q {
            url += "&q=\(q)"
        }
        
        var request = URLRequest(url: NSURL(string: url)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: TastyResponseRecipe.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
