//
//  NetworkService.swift
//  FoodRecipeProject
//
//  Created by MAC on 30.09.2022.
//

import Foundation

protocol NetworkService {
    func fetchData(completion: @escaping ((ModelCollectionRecipe) -> Void))
}

class NetworkManager: NetworkService {
    
    func fetchData(completion: @escaping ((ModelCollectionRecipe) -> Void)) {
        var urlString = URL(string: "https://api.spoonacular.com/recipes/complexSearch?%20")
        
        urlString?.append(queryItems: [URLQueryItem(name: "query", value: "pasta"),
                                       URLQueryItem(name: "apiKey", value: "35cfbd92c4f2445693cd12ad0dbd80af")])
        
        guard let url = urlString else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    print(response)
                    if let data = data {
                        let recipes = try? JSONDecoder().decode(ModelCollectionRecipe.self, from: data)
                        guard let recipes = recipes else { return }
                        completion(recipes)
                        print(recipes.results)
                    }
                }
            }
        })
        .resume()
    }
}
