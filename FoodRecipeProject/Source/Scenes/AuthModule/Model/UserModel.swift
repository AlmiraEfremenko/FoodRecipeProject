//
//  UserInfo.swift
//  FoodRecipeProject
//
//  Created by MAC on 30.09.2022.
//

import Foundation

class UserModel: NSObject, NSCoding {
    
    let name: String
    let city: String
    let phone: String
    
    init(name: String, city: String, phone: String) {
        self.name = name
        self.city = city
        self.phone = phone
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(city, forKey: "city")
        coder.encode(phone, forKey: "phone")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        city = coder.decodeObject(forKey: "city") as? String ?? ""
        phone = coder.decodeObject(forKey: "phone") as? String ?? ""
    }
}
