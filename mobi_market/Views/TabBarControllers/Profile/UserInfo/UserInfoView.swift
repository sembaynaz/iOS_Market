//
//  UserInfoView.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 25.11.2023.
//

import Foundation
import UIKit

class UserInfoView: UIView {
    let backButton: BarButtonItem = {
        let button = BarButtonItem()
        button.setTitle("Отмена", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let doneButton: BarButtonItem = {
        let button = BarButtonItem()
        button.setTitle("Готово", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfilePhoto")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let changePhotoButton: UIButton = {
        let button = UIButton()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        button.titleLabel?.font = font
        button.setTitle("Выбрать фотографию", for: .normal)
        button.setTitleColor(UIColor(named: "Blue"), for: .normal)
        return button
    }()
    private let firstBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    private let secondBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    let nameTextField: ProfileTextField = {
        let textField = ProfileTextField()
        textField.font = UIFont(name: "Gothampro-Medium", size: 16)
        let font = UIFont(name: "Gothampro-Medium", size: 16)
        textField.setPlaceholderText("Имя")
        return textField
    }()
    let secondNameTextField: ProfileTextField = {
        let textField = ProfileTextField()
        textField.font = UIFont(name: "Gothampro-Medium", size: 16)
        let font = UIFont(name: "Gothampro-Medium", size: 16)
        textField.setPlaceholderText("Отчество")
        return textField
    }()
    let lastNameTextField: ProfileTextField = {
        let textField = ProfileTextField()
        textField.font = UIFont(name: "Gothampro-Medium", size: 16)
        let font = UIFont(name: "Gothampro-Medium", size: 16)
        textField.setPlaceholderText("Фамилия")
        textField.setTextToTextField("Алеся")
        return textField
    }()
    let birthDateTextField: ProfileTextField = {
        let textField = ProfileTextField()
        textField.font = UIFont(name: "Gothampro-Medium", size: 16)
        let font = UIFont(name: "Gothampro-Medium", size: 16)
        textField.setPlaceholderText("Дата рождения")
        textField.keyboardType = .numberPad
        return textField
    }()
    let phoneNumberButton: UIButton = {
        let button = UIButton()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        button.titleLabel?.font = font
        button.contentHorizontalAlignment = .left
        button.setTitle("Добавить номер", for: .normal)
        button.setTitleColor(UIColor(named: "Blue"), for: .normal)
        return button
    }()
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        label.font = font
        label.textColor = UIColor(named: "Gray")
        label.text = "0(000) 000 000"
        return label
    }()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(
            red: 247 / 255,
            green: 246 / 255,
            blue: 249 / 255,
            alpha: 1
        )
        return view
    }()
    let emailTextField: ProfileTextField = {
        let textField = ProfileTextField()
        textField.font = UIFont(name: "Gothampro-Medium", size: 16)
        let font = UIFont(name: "Gothampro-Medium", size: 16)
        textField.setPlaceholderText("Email")
        textField.setTextToTextField("nikitina.alesya@gmail.com")
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

extension UserInfoView {
    private func setup() {
        backgroundColor = UIColor(named: "Background")
        
        setProfilePhotoImageView()
        setChangePhotoButton()
        setFirstBackgroundView()
        setSecondBackgroundView()
        setNameTextField()
        setLastNameTextField()
        setSecondNameTextField()
        setBirthDateTextField()
        setPhoneNumberButton()
        setPhoneNumberLabel()
        setSeparatorView()
        setEmailTextField()
    }
    
    private func setProfilePhotoImageView() {
        addSubview(profilePhotoImageView)
        profilePhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.centerX.equalTo(snp.centerX)
        }
    }
    private func setChangePhotoButton() {
        addSubview(changePhotoButton)
        changePhotoButton.snp.makeConstraints { make in
            make.top.equalTo(profilePhotoImageView.snp.bottom).offset(12)
            make.centerX.equalTo(snp.centerX)
        }
    }
    private func setFirstBackgroundView() {
        addSubview(firstBackgroundView)
        firstBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(changePhotoButton.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(179)
        }
    }
    private func setSecondBackgroundView() {
        addSubview(secondBackgroundView)
        secondBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(firstBackgroundView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(89)
        }
    }
    private func setNameTextField() {
        firstBackgroundView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(39)
        }
    }
    private func setLastNameTextField() {
        firstBackgroundView.addSubview(lastNameTextField)
        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(39)
        }
    }
    private func setSecondNameTextField() {
        firstBackgroundView.addSubview(secondNameTextField)
        secondNameTextField.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(39)
        }
    }
    private func setBirthDateTextField() {
        firstBackgroundView.addSubview(birthDateTextField)
        birthDateTextField.delegate = self
        
        birthDateTextField.snp.makeConstraints { make in
            make.top.equalTo(secondNameTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(39)
        }
    }
    private func setPhoneNumberButton() {
        secondBackgroundView.addSubview(phoneNumberButton)
        
        phoneNumberButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.height.equalTo(32)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    private func setPhoneNumberLabel() {
        phoneNumberButton.addSubview(phoneNumberLabel)
        phoneNumberLabel.snp.makeConstraints { make in
            make.right.equalTo(phoneNumberButton.snp.right).inset(0)
            make.centerY.equalTo(phoneNumberButton.snp.centerY)
        }
    }
    private func setSeparatorView() {
        secondBackgroundView.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberButton.snp.bottom).offset(6)
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    private func setEmailTextField() {
        secondBackgroundView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(39)
        }
    }
}

extension UserInfoView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = birthDateTextField.text as NSString? else {
            return false
        }
        
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        let isNumber = allowedCharacterSet.isSuperset(of: characterSet)
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        
        if string.isEmpty {
            return true
        }
        
        
        let newLength = newText.count
        if isNumber && newLength <= 10 {
            let formattedText = formatNumber(text: newText)
            textField.text = formattedText
            
            birthDateTextField.setTextToTextField(formattedText)
        }
        
        
        return false
    }
    func handleBirthDateInput() {
        if let text = birthDateTextField.text, text.count == 8 {
            let formattedText = "\(text.prefix(2)).\(text.dropFirst(2).prefix(2)).\(text.dropFirst(4))"
            birthDateTextField.text = formattedText
        }
    }
    func formatNumber(text: String) -> String {
        var formattedText = text.replacingOccurrences(of: ".", with: "")
        if formattedText.count >= 2 {
            formattedText.insert(".", at: formattedText.index(formattedText.startIndex, offsetBy: 2))
        }
        if formattedText.count >= 5 {
            formattedText.insert(".", at: formattedText.index(formattedText.startIndex, offsetBy: 5))
        }
        return formattedText
    }
}
