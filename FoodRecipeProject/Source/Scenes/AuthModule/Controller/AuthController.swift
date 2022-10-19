//
//  AuthController.swift
//  FoodRecipeProject
//
//  Created by MAC on 30.09.2022.
//

import UIKit

class AuthController: UIViewController {
    
    // MARK: - Property
    
    private var registrationView: AuthView? {
        guard isViewLoaded else { return nil }
        return view as? AuthView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = AuthView()
        let button = UIBarButtonItem(customView: registrationView?.buttonSave ?? UIView())
        navigationItem.rightBarButtonItem = button
        saveDataUser()
        actionCorrectData()
        getMainCollectionFood()
    }
    
    // MARK: - Save data user
    
    private func saveDataUser() {
        registrationView?.actionButtonSave = { [weak self] in
            
            guard let name = self?.registrationView?.nameUser.text else { return }
            guard let city = self?.registrationView?.cityName.text else { return }
            guard let phone = self?.registrationView?.phoneNumber.text else { return }
            
            let userObject = UserModel(name: name,
                                       city: city,
                                       phone: phone)
            UserSettings.userModel = userObject
        }
    }
    
    // MARK: - Button activity in case of incorrect data entry
    
    private func actionCorrectData() {
        registrationView?.incorrectData = { [weak self] in
            
            let alertController = UIAlertController(title: nil, message: "Enter all the data and click save", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alertController.addAction(action)
            self?.present(alertController, animated: true)
        }
    }
    
    // MARK: - Button proceed and open collection recipes
    
    private func getMainCollectionFood() {
        registrationView?.activeButtonProceed = { [weak self] in
            
            let tabBar = MainTabBarController()
            self?.navigationController?.pushViewController(tabBar, animated: false)
        }
    }
}
