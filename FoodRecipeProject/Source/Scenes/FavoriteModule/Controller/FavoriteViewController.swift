//
//  FavoriteViewController.swift
//  FoodRecipeProject
//
//  Created by MAC on 06.10.2022.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController {
    
    var favoriteRecipes = FavoriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoriteRecipes
        title = "Favorite"
    }
}
