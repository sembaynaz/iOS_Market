//
//  SignupViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 20.10.2023.
//

import UIKit

class SignupViewController: UIViewController {
    let customView = SignupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        setupView()
    }
    
    func setupView() {
        view.addSubview(customView)
        customView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        customView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
}

extension SignupViewController {
    @objc func signupButtonTapped() {
        let vc = CreatePasswordViewController()
        vc.title = "Регистрация"
        navigationController?.show(vc, sender: self)
    }
}

extension SignupViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
