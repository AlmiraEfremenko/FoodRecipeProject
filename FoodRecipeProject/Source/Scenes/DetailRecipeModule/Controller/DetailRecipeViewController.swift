//
//  DetailRecipeViewController.swift
//  FoodRecipeProject
//
//  Created by MAC on 03.10.2022.
//

import Foundation
import UIKit

class DetailRecipeViewController: UIViewController {
    
    var recipe = DetailRecipeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = recipe
    }
}
