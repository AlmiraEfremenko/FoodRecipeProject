//
//  ProfileViewController.swift
//  FoodRecipeProject
//
//  Created by MAC on 06.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Property
    
    private var profileView: ProfileView? {
        guard isViewLoaded else { return nil }
        return view as? ProfileView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = ProfileView()
        configureButtonSave()
        showDataUser()
        actionSaveDataUserAfterEdit()
    }
    
    private func configureButtonSave() {
        let button = UIBarButtonItem(customView: profileView?.buttonSave ?? UIView())
        navigationItem.rightBarButtonItem = button
    }
    
    private func actionSaveDataUserAfterEdit() {
        profileView?.actionButtonSave = {
            guard let name = self.profileView?.nameUser.text else { return }
            guard let city = self.profileView?.cityName.text else { return }
            guard let phone = self.profileView?.phoneNumber.text else { return }
            
            let userObject = UserModel(name: name,
                                       city: city,
                                       phone: phone)
            
            UserSettings.userModel = userObject
            self.showDataUser()
        }
    }
    
    private func showDataUser() {
        self.profileView?.nameUser.text = UserSettings.userModel?.name
        self.profileView?.cityName.text = UserSettings.userModel?.city
        self.profileView?.phoneNumber.text = UserSettings.userModel?.phone
    }
}
