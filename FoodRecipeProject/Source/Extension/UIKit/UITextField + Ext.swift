//
//  Extention.swift
//  FoodRecipeProject
//
//  Created by MAC on 06.10.2022.
//

import UIKit

// MARK: - Settings padding in textField

extension UITextField {
    
    convenience init(placeholder: String,
                     borderWidth: CGFloat? = 1 ,
                     borderColor: CGColor? = UIColor.gray.cgColor,
                     cornerRadius: CGFloat? = 10) {
        self.init()
        self.placeholder = placeholder
        self.layer.borderWidth = borderWidth ?? 0
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = cornerRadius ?? 0
        self.adjustsFontSizeToFitWidth = true
        self.addPaddingToTextField()
    }
    
    func addPaddingToTextField() {
        let paddingView: UIView = UIView.init(frame: CGRectMake(0, 0, 8, 20))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
