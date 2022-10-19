//
//  SceneDelegate.swift
//  FoodRecipeProject
//
//  Created by MAC on 30.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let token = UserSettings.userModel
        
        if token != nil {
            let tabBar = MainTabBarController()
            let navigationController = UINavigationController(rootViewController: tabBar)
            window?.rootViewController = navigationController
            
        } else {
            let authController = AuthController()
            let navigationController = UINavigationController(rootViewController: authController)
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = .specialBackground
    }
}
