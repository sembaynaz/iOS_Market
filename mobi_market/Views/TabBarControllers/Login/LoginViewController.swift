//
//  ViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 18.10.2023.
//

import UIKit
import SnapKit
import UserNotifications


class LoginViewController: UIViewController {
    let notificationCenter = UNUserNotificationCenter.current()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension LoginViewController {
    func setup() {
        view.backgroundColor = .white
        navigationItem.title = " "
        
        setLogoImage()
        setLogoText()
        setEmailTextField()
        setPasswordTextField()
        setLoginButton()
        setSignupButton()
        setErrorImage()
    }
    func setLogoImage() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(-26)
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
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(120)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    func setPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    func setLoginButton() {
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(82)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    func setSignupButton() {
        view.addSubview(signupButton)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        signupButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    func setErrorImage() {
        view.addSubview(errorImage)
        errorImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(-40)
            make.horizontalEdges.equalToSuperview().inset(27)
            make.height.equalTo(60)
        }
    }
}

extension LoginViewController {
    @objc func signupButtonTapped() {
        let vc = SignupViewController()
        vc.title = "Регистрация"
        navigationController?.show(vc, sender: self)
    }
    
    @objc func loginButtonTapped() {
        if emailTextField.text == "Neobis" && passwordTextField.text == "neobis2023" {
            startApp()
        } else {
            self.errorImage.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.errorImage.isHidden = true
            }
        }
    }
}

extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController {
    func startApp() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let window = appDelegate.window ?? UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarViewController = TabBarViewController()
        
        window.rootViewController = tabBarViewController
        window.makeKeyAndVisible()
        
        tabBarViewController.modalPresentationStyle = .fullScreen
        self.present(tabBarViewController, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if !passwordTextField.text!.isEmpty && !emailTextField.text!.isEmpty {
            loginButton.setActive(true)
            loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        } else {
            loginButton.setActive(false)
        }
    }
}
