//
//  SignupView.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 25.11.2023.
//

import Foundation
import UIKit

class SignupView: UIView {
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo_image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let logoText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Nunito-ExtraBold", size: 18)
        label.text = "MOBI MARKET"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nameTextField: TextField = {
        let textField = TextField()
        textField.setPlaceholderText("Имя пользователя")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let emailTextField: TextField = {
        let textField = TextField()
        textField.setPlaceholderText("Почта")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let signupButton: Button = {
        let button = Button()
        button.setActive(false)
        button.setTitle("Войти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }
}

extension SignupView {
    func setUp() {
        backgroundColor = .white
        setLogoImage()
        setLogoText()
        setEmailTextField()
        setPasswordTextField()
        setLoginButton()
    }
    
    func setLogoImage() {
        addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.width.equalTo(80)
            make.left.equalTo(132)
        }
    }
    func setLogoText() {
        addSubview(logoText)
        logoText.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(8)
            make.centerX.equalTo(snp.centerX)
        }
    }
    func setEmailTextField() {
        addSubview(nameTextField)
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(logoText.snp.bottom).offset(68)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    func setPasswordTextField() {
        addSubview(emailTextField)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(52)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    func setLoginButton() {
        addSubview(signupButton)
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(46)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}

extension SignupView {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if isValidEmail(emailTextField.text!) && !nameTextField.text!.isEmpty {
            signupButton.setActive(true)
        } else {
            signupButton.setActive(false)
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
