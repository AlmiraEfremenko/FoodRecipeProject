//
//  DetailRecipeView.swift
//  FoodRecipeProject
//
//  Created by MAC on 03.10.2022.
//

import Foundation
import UIKit
import SnapKit

class DetailRecipeView: UIView {
    
    // MARK: - Property
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 20, weight: .medium)
        return title
    }()
    
    var recipes: Result? {
        didSet {
            
            title.text = recipes?.title
            let urlString = URL(string: recipes?.image ?? "")
            
            DispatchQueue.global().async {
                guard let url = urlString else { return }
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    guard let data = data else {
                        self.image.image = UIImage(named: "meal")
                        return
                    }
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: - Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarhy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Hierarhy
    
    private func setupHierarhy() {
        addSubview(image)
        addSubview(title)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        image.snp.makeConstraints { make in
            make.top.equalTo(130)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-400)
            make.left.right.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
}
