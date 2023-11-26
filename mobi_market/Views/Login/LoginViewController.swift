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
    let customView = LoginView()
    let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.title = " "
    }
    
    func setupView() {
        view.addSubview(customView)
        customView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        customView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        customView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

extension LoginViewController {
    @objc func signupButtonTapped() {
        let vc = SignupViewController()
        vc.title = "Регистрация"
        navigationController?.show(vc, sender: self)
    }
    
    @objc func loginButtonTapped() {
        if customView.emailTextField.text == "Neobis" && customView.passwordTextField.text == "neobis2023" {
            startApp()
        } else {
            customView.errorImage.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.customView.errorImage.isHidden = true
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
