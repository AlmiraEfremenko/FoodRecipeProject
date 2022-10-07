//
//  CollectionViewCell.swift
//  FoodRecipeProject
//
//  Created by MAC on 30.09.2022.
//

import Foundation
import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifire = "CollectionViewCell"
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 3
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 15, weight: .medium)
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
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(5)
            make.left.equalTo(15)
            make.right.equalTo(-5)
        }
    }
}
