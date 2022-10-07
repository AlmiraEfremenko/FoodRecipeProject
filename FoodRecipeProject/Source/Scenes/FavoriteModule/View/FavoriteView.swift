//
//  FavoriteView
//  FoodRecipeProject
//
//  Created by MAC on 06.10.2022.
//

import Foundation
import UIKit
import SnapKit

class FavoriteView: UIView {
    
    // MARK: - Property
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = UIImage(systemName: "heart.fill")?.withTintColor(.systemPink.withAlphaComponent(0.5), renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.lineBreakMode = .byWordWrapping
        title.text = "Your Favorite recipe"
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 20, weight: .medium)
        return title
    }()
    
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
}
