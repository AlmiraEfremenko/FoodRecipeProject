//
//  CollectionViewCell.swift
//  FoodRecipeProject
//
//  Created by MAC on 30.09.2022.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifire = "CollectionViewCell"
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = Metric.cornerRadius
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = Metric.numberOfLines
        title.font = .systemFont(ofSize: Metric.titleFont, weight: .medium)
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
            make.left.equalTo(Metric.imageLeftAnchor)
            make.right.equalTo(Metric.imageRightAnchor)
            make.height.equalTo(Metric.imageHeight)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(Metric.offset)
            make.left.equalTo(Metric.titleLeftAnchor)
            make.right.equalTo(Metric.titleRightAnchor)
        }
    }
}

extension CollectionViewCell {
    
    enum Metric {
        static let cornerRadius: CGFloat = 3
        static let numberOfLines = 2
        static let titleFont: CGFloat = 15
        static let imageLeftAnchor: CGFloat = 10
        static let imageRightAnchor: CGFloat = -10
        static let imageHeight: CGFloat = 200
        static let offset: CGFloat = 5
        static let titleLeftAnchor: CGFloat = 10
        static let titleRightAnchor: CGFloat = -10
    }
}
