//
//  TabBarController.swift
//  FoodRecipeProject
//
//  Created by MAC on 05.10.2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateViewControllers(viewController: CollectionViewController(), navViewController: UINavigationController(),
                                    title: "",
                                    image: UIImage(systemName: "house.fill"),
                                    tag: 0),
            generateViewControllers(viewController: FavoriteViewController(), navViewController: UINavigationController(),
                                    title: "",
                                    image: UIImage(systemName: "heart.fill"),
                                    tag: 1),
            generateViewControllers(viewController: ProfileViewController(), navViewController: UINavigationController(),
                                    title: "",
                                    image: UIImage(systemName: "person.fill"),
                                    tag: 2)
        ]
    }
    
    private func generateViewControllers(viewController: UIViewController, navViewController: UINavigationController, title: String, image: UIImage?, tag: Int) -> UINavigationController {
        navViewController.tabBarItem.title = title
        navViewController.tabBarItem.image = image
        navViewController.tabBarItem.tag = tag
        navViewController.pushViewController(viewController, animated: false)
        return navViewController
    }
}
