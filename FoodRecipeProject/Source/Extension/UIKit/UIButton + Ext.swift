//
//  UIButton + Ext.swift
//  FoodRecipeProject
//
//  Created by MAC on 18.10.2022.
//

import UIKit

class SaveButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setTitle("Save", for: .normal)
        setTitleColor(.blue, for: .normal)
    }
}
