//
//  Extention.swift
//  FoodRecipeProject
//
//  Created by MAC on 06.10.2022.
//

import Foundation
import UIKit

// MARK: - Settings padding in textField

extension UITextField {
    func addPaddingToTextField() {
        let paddingView: UIView = UIView.init(frame: CGRectMake(0, 0, 8, 20))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
