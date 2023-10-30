//
//  SignupViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 20.10.2023.
//

import UIKit

class SignupViewController: UIViewController {

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
    let signupButton: Button = {
        let button = Button()
        button.setActive(false)
        button.setTitle("Войти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

extension SignupViewController {
    func setUp() {
        view.backgroundColor = .white
        navigationItem.title = ""
        setLogoImage()
        setLogoText()
        setEmailTextField()
        setPasswordTextField()
        setLoginButton()
    }
    
    func setLogoImage() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.width.equalTo(80)
            make.left.equalTo(132)
        }
    }
    func setLogoText() {
        view.addSubview(logoText)
        logoText.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(8)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    func setEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoText.snp.bottom).offset(68)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    func setPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(52)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    func setLoginButton() {
        view.addSubview(signupButton)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(46)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}

extension SignupViewController {
    @objc func signupButtonTapped() {
        let vc = CreatePasswordViewController()
        vc.title = "Регистрация"
        navigationController?.show(vc, sender: self)
    }
}
