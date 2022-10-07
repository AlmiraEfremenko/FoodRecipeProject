//
//  ProfileView.swift
//  FoodRecipeProject
//
//  Created by MAC on 06.10.2022.
//

import Foundation
import UIKit
import SnapKit

class ProfileView: UIView {
    
    // MARK: - Property
    
    private lazy var avatar: UIImageView = {
        var avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 150 / 2
        avatar.clipsToBounds = true
        avatar.image = UIImage(named: "avatar")
        return avatar
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var nameUser: UITextField = {
        let nameUser = UITextField()
        nameUser.placeholder = "Name"
        nameUser.addPaddingToTextField()
        return nameUser
    }()
    
    lazy var cityName: UITextField = {
        let cityName = UITextField()
        cityName.placeholder = "City"
        cityName.addPaddingToTextField()
        return cityName
    }()
    
    lazy var phoneNumber: UITextField = {
        let phoneNumber = UITextField()
        phoneNumber.placeholder = "Phone number"
        phoneNumber.delegate = self
        phoneNumber.addPaddingToTextField()
        return phoneNumber
    }()
    
    lazy var buttonSave: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(tapButtonSave), for: .touchUpInside)
        return button
    }()
    
    var isChangesButtonSave = false
    var actionButtonSave: (() -> Void)?
    
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
        addSubview(avatar)
        addSubview(stackView)
        stackView.addArrangedSubview(nameUser)
        stackView.addArrangedSubview(cityName)
        stackView.addArrangedSubview(phoneNumber)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        
        avatar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.height.width.equalTo(150)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
        
        nameUser.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        cityName.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        phoneNumber.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - Action buttonSave
    
    @objc func tapButtonSave() {
        
        if !isChangesButtonSave {
            buttonSave.setTitle("Edit", for: .normal)
            nameUser.isEnabled = false
            cityName.isEnabled = false
            phoneNumber.isEnabled = false
            actionButtonSave?()
        } else {
            buttonSave.setTitle("Save", for: .normal)
            nameUser.isEnabled = true
            cityName.isEnabled = true
            phoneNumber.isEnabled = true
        }
        isChangesButtonSave.toggle()
    }
}

// MARK: - Settings format textField

extension ProfileView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+X (XXX) XXX-XXXX", phone: newString)
        return false
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
