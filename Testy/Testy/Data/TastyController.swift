//
//  TastyController.swift
//  Testy
//
//  Created by Saint Germain on 04/07/2022.
//

import Combine
import Foundation

public class TastyController {
    let baseUrl = "https://tasty.p.rapidapi.com"
    let rapidApiHost = "tasty.p.rapidapi.com"
    let rapidApiKey = "c4620708c3msh37263e720328b1cp1317a7jsncc90dabc8d72"
    
    func recipeList(from offset: Int, size: Int, tags: String?, q: String?, completion: @escaping (Result<TastyResponseRecipe,Error>) -> Void) {
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

        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data else {
                print("error while fetching data")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(TastyResponseRecipe.self, from: data)
                print(decodedData)
                DispatchQueue.main.async { completion(.success(decodedData)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
                print(error)
            }
        }).resume()
    }
}
