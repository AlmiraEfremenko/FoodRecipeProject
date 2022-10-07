//
//  UserDefaults.swift
//  FoodRecipeProject
//
//  Created by MAC on 06.10.2022.
//

import Foundation

final class UserSettings {
    
    private enum SettingsKey: String {
        case usermodel
    }
    
    static var userModel: UserModel? {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKey.usermodel.rawValue) as? Data,
                  let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserModel else { return nil}
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKey.usermodel.rawValue
            
            if let userModel = newValue {
                if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    defaults.set(saveData, forKey: key)
                } else {
                    defaults.removeObject(forKey: key)
                }
            }
        }
    }
}
