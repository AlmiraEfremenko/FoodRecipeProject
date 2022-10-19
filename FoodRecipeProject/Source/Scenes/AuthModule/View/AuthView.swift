//
//  AuthView.swift
//  FoodRecipeProject
//
//  Created by MAC on 30.09.2022.
//

import UIKit
import SnapKit

class AuthView: UIView {
    
    // MARK: - Property
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.font = .systemFont(ofSize: Metric.labelFont, weight: .medium)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Metric.stackViewSpacing
        return stackView
    }()
    
    lazy var nameUser = UITextField(placeholder: "Name",
                                    borderWidth: Metric.borderWidth,
                                    borderColor: UIColor.gray.cgColor,
                                    cornerRadius: Metric.cornerRadius)
    
    lazy var cityName = UITextField(placeholder: "City",
                                    borderWidth: Metric.borderWidth,
                                    borderColor: UIColor.gray.cgColor,
                                    cornerRadius: Metric.cornerRadius)
    
    lazy var phoneNumber: UITextField = {
        let phoneNumber = UITextField()
        phoneNumber.placeholder = "Phone number"
        phoneNumber.layer.borderWidth = Metric.borderWidth
        phoneNumber.layer.borderColor = UIColor.specialLightBrown.cgColor
        phoneNumber.layer.cornerRadius = Metric.cornerRadius
        phoneNumber.delegate = self
        phoneNumber.addPaddingToTextField()
        return phoneNumber
    }()
    
    lazy var buttonProceed: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = Metric.cornerRadius
        button.setTitle("Proceed", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapButtonProceed), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonSave = SaveButton(type: .system)
    
    var isChangesButtonSave = false
    var actionButtonSave: (() -> Void)?
    var incorrectData: (() -> Void)?
    var activeButtonProceed: (() -> Void)?
    
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
            make.top.equalTo(Metric.labelTopConstraints)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(Metric.offset)
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
        
        buttonProceed.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(Metric.offset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metric.buttonWidth)
            make.height.equalTo(Metric.buttonHeight)
        }
    }
    
    // MARK: - Action buttonProceed
    
    @objc func tapButtonProceed() {
        
        guard let name = nameUser.text else { return }
        guard let city = cityName.text else { return }
        guard let phone = phoneNumber.text else { return }
        
        if !name.isEmpty, !city.isEmpty, !phone.isEmpty && phone.count == Metric.phoneCount && isChangesButtonSave {
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

extension AuthView {
    
    enum Metric {
        static let labelFont: CGFloat = 25
        static let stackViewSpacing: CGFloat = 20
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let labelTopConstraints: CGFloat = 150
        static let offset: CGFloat = 50
        static let stackViewWidth: CGFloat = 300
        static let stackViewHeight: CGFloat = 200
        static let buttonWidth: CGFloat = 150
        static let buttonHeight: CGFloat = 50
        static let phoneCount = 17
    }
}
