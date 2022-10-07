//
//  ModelCollectionRecipes.swift
//  FoodRecipeProject
//
//  Created by MAC on 30.09.2022.
//

import Foundation

// MARK: - ModelCollectionRecipe

struct ModelCollectionRecipe: Codable {
    let results: [Result]
    let offset : Int
    let number: Int
    let totalResults: Int
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: ImageType
}

enum ImageType: String, Codable {
    case jpg = "jpg"
}
