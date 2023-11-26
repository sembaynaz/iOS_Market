//
//  LoginView.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 25.11.2023.
//

import Foundation
import UIKit

class LoginView: UIView {
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
    let emailTextField: TextField = {
        let textField = TextField()
        textField.setPlaceholderText("Имя пользователя")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let passwordTextField: TextField = {
        let textField = TextField()
        textField.setPlaceholderText("Пароль")
        textField.setPasswordTextField(true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let loginButton: Button = {
        let button = Button()
        button.setActive(false)
        button.setTitle("Войти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let signupButton: UIButton = {
        let button = UIButton()
        let font = UIFont(name: "GothamPro-Medium", size: 14)
        button.backgroundColor = nil
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(UIColor(named: "Blue"), for: .normal)
        button.titleLabel?.font = font
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let errorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Error")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
}

extension LoginView {
    func setup() {
        backgroundColor = .white
        
        setLogoImage()
        setLogoText()
        setEmailTextField()
        setPasswordTextField()
        setLoginButton()
        setSignupButton()
        setErrorImage()
    }
    func setLogoImage() {
        addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(-26)
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
        addSubview(emailTextField)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(120)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    func setPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    func setLoginButton() {
        addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(82)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    func setSignupButton() {
        addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    func setErrorImage() {
        addSubview(errorImage)
        errorImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(-40)
            make.horizontalEdges.equalToSuperview().inset(27)
            make.height.equalTo(60)
        }
    }
}

extension LoginView: UITextFieldDelegate {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if !passwordTextField.text!.isEmpty && !emailTextField.text!.isEmpty {
            loginButton.setActive(true)
        } else {
            loginButton.setActive(false)
        }
    }
}
