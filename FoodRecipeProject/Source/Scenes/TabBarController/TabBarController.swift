//
//  TabBarController.swift
//  FoodRecipeProject
//
//  Created by MAC on 05.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupItems()
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - SetupTabBar
    
    private func setupTabBar() {
        tabBar.backgroundColor = .specialBackground
        tabBar.layer.borderWidth = Metric.borderWidth
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
        tabBar.tintColor = .specialGreen
    }
    
    // MARK: - SetupItems
    
    private func setupItems() {
        let navigationMainVC = UINavigationController()
        let mainVC = CollectionViewController()
        navigationMainVC.pushViewController(mainVC, animated: true)
        
        let favoriteVC = FavoriteViewController()
        
        let navigationProfileVC = UINavigationController()
        let profileVC = ProfileViewController()
        navigationProfileVC.pushViewController(profileVC, animated: true)
        
        setViewControllers([navigationMainVC, favoriteVC, navigationProfileVC], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Main"
        items[1].title = "Favorite"
        items[2].title = "Profile"
        
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "heart.fill")
        items[2].image = UIImage(systemName: "person.fill")
    }
}

extension MainTabBarController {
    
    enum Metric {
        static let borderWidth = 0.5
    }
}
