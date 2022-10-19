//
//  ProfileView.swift
//  FoodRecipeProject
//
//  Created by MAC on 06.10.2022.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    // MARK: - Property
    
    private lazy var avatar: UIImageView = {
        var avatar = UIImageView()
        avatar.layer.cornerRadius = Metric.cornerRadiusAvatar
        avatar.clipsToBounds = true
        avatar.image = UIImage(named: "avatar")
        return avatar
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Metric.stackViewSpacing
        return stackView
    }()
    
    lazy var nameUser = UITextField(placeholder: "Name",
                                    borderWidth: nil,
                                    borderColor: nil,
                                    cornerRadius: nil)
    
    lazy var cityName = UITextField(placeholder: "City",
                                    borderWidth: nil,
                                    borderColor: nil,
                                    cornerRadius: nil)
    
    
    lazy var phoneNumber: UITextField = {
        let phoneNumber = UITextField()
        phoneNumber.placeholder = "Phone number"
        phoneNumber.delegate = self
        phoneNumber.addPaddingToTextField()
        return phoneNumber
    }()
    
    lazy var buttonSave = SaveButton(type: .system)
    
    var isChangesButtonSave = false
    var actionButtonSave: (() -> Void)?
    
    // MARK: - Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarhy()
        setupLayout()
        buttonSave.addTarget(self, action: #selector(tapButtonSave), for: .touchUpInside)
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
            make.top.equalTo(Metric.topAvatarAnchor)
            make.height.width.equalTo(Metric.heightWidthAvatarAnchor)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(Metric.offset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metric.stackViewWidth)
            make.height.equalTo(Metric.stackViewHeight)
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

extension ProfileView {
    
    enum Metric {
        static let cornerRadiusAvatar: CGFloat = 150 / 2
        static let stackViewSpacing: CGFloat = 20
        static let topAvatarAnchor: CGFloat = 170
        static let heightWidthAvatarAnchor: CGFloat = 150
        static let offset: CGFloat = 50
        static let stackViewWidth: CGFloat = 300
        static let stackViewHeight: CGFloat = 200
    }
}
