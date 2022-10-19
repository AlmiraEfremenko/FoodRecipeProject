//
//  FavoriteView
//  FoodRecipeProject
//
//  Created by MAC on 06.10.2022.
//

import UIKit
import SnapKit

class FavoriteView: UIView {
    
    // MARK: - Property
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = UIImage(systemName: "heart.fill")
        image.tintColor = .specialGreen
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.lineBreakMode = .byWordWrapping
        title.text = "Your Favorite recipe"
        title.numberOfLines = Metric.numberOfLines
        title.font = .systemFont(ofSize: Metric.titleFont, weight: .medium)
        return title
    }()
    
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(Metric.imageWidth)
            make.height.equalTo(Metric.imageHeight)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(Metric.offset)
            make.centerX.equalToSuperview()
        }
    }
}

extension FavoriteView {
    
    enum Metric {
        static let numberOfLines = 2
        static let titleFont: CGFloat = 20
        static let imageWidth: CGFloat = 150
        static let imageHeight: CGFloat = 150
        static let offset: CGFloat = 50
    }
}
