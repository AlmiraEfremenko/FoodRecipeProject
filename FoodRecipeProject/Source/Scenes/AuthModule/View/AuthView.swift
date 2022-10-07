//
//  AuthView.swift
//  FoodRecipeProject
//
//  Created by MAC on 30.09.2022.
//

import Foundation
import UIKit
import SnapKit

class AuthView: UIView {
    
    // MARK: - Property
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
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
        nameUser.layer.borderWidth = 1
        nameUser.layer.borderColor = UIColor.gray.cgColor
        nameUser.layer.cornerRadius = 10
        nameUser.addPaddingToTextField()
        return nameUser
    }()
    
    lazy var cityName: UITextField = {
        let cityName = UITextField()
        cityName.placeholder = "City"
        cityName.layer.borderWidth = 1
        cityName.layer.borderColor = UIColor.gray.cgColor
        cityName.layer.cornerRadius = 10
        cityName.addPaddingToTextField()
        return cityName
    }()
    
    lazy var phoneNumber: UITextField = {
        let phoneNumber = UITextField()
        phoneNumber.placeholder = "Phone number"
        phoneNumber.layer.borderWidth = 1
        phoneNumber.layer.borderColor = UIColor.gray.cgColor
        phoneNumber.layer.cornerRadius = 10
        phoneNumber.delegate = self
        phoneNumber.addPaddingToTextField()
        return phoneNumber
    }()
    
    lazy var buttonProceed: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 48/255, green: 189/255, blue: 117/255, alpha: 255/255)
        button.layer.cornerRadius = 10
        button.setTitle("Proceed", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapButtonProceed), for: .touchUpInside)
        return button
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
    var incorrectData: (() -> Void)?
    var activeButtonProceed: (() -> Void)?
    
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
        addSubview(label)
        addSubview(stackView)
        stackView.addArrangedSubview(nameUser)
        stackView.addArrangedSubview(cityName)
        stackView.addArrangedSubview(phoneNumber)
        addSubview(buttonProceed)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(150)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(50)
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
        
        buttonProceed.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Action buttonProceed
    
    @objc func tapButtonProceed() {
        
        guard let name = nameUser.text else { return }
        guard let city = cityName.text else { return }
        guard let phone = phoneNumber.text else { return }
        
        if !name.isEmpty, !city.isEmpty, !phone.isEmpty && phone.count == 17 && isChangesButtonSave {
            activeButtonProceed?()
        } else {
            incorrectData?()
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

extension AuthView: UITextFieldDelegate {
    
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
