//
//  UserDefaults.swift
//  FoodRecipeProject
//
//  Created by MAC on 06.10.2022.
//

import Foundation

final class UserSettings {
    
    private enum SettingsKey: String {
        case userModel
    }
    
    static var userModel: UserModel? {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKey.userModel.rawValue) as? Data,
                  let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserModel
            else { return nil }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKey.userModel.rawValue
            
            if let newUserModel = newValue {
                if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: newUserModel, requiringSecureCoding: false) {
                    defaults.set(saveData, forKey: key)
                } else {
                    defaults.removeObject(forKey: key)
                }
            }
        }
    }
}
