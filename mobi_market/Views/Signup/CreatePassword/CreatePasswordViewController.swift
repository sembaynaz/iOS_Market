//
//  CreatePasswordViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 28.10.2023.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    var isNextButtonTapped: Bool = false
    let customView = CreatePasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension CreatePasswordViewController {
    func setupUI() {
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        customView.delegate = self
        setShowPasswordButton()
    }
    
    func setShowPasswordButton() {
        let showPasswordButton = UIBarButtonItem(image: UIImage(named: "Secure2"), style: .plain, target: self, action: #selector(didToggleShowPassword))
        navigationItem.rightBarButtonItem = showPasswordButton
    }
}

extension CreatePasswordViewController: CreatePasswordViewDelegate {
    func didTapNextButton() {
        isNextButtonTapped = true
        
        customView.titleLabel.text = "Повторите пароль"
        customView.nextButton.setTitle("Готово", for: .normal)
        
        customView.secondPasswordTextField.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.customView.secondPasswordTextField.becomeFirstResponder()
            print("second \(self.customView.secondPasswordTextField.isFirstResponder)")
        }
    }
    
    func didTapDoneButton() {
        if !customView.originalPassword2.isEmpty {
            if customView.originalPassword2 == customView.originalPassword1 {
                customView.errorLabel.isHidden = true
                customView.nextButton.setActive(true)
                navigationController?.popToRootViewController(animated: true)
            } else {
                customView.errorLabel.isHidden = false
                customView.nextButton.setActive(false)
            }
        }
    }
    
    @objc func didToggleShowPassword() {
        customView.isSecure.toggle()
        
        let passwordLength = customView.originalPassword1.count
        let maskedPassword = String(repeating: "●", count: passwordLength)
        customView.firstPasswordTextField.text = customView.isSecure ? maskedPassword : customView.originalPassword1
        customView.isSpace(textField: customView.firstPasswordTextField, hashPassword: customView.firstPasswordTextField.text!)
        
        let passwordLength1 = customView.originalPassword2.count
        let maskedPassword1 = String(repeating: "●", count: passwordLength1)
        customView.secondPasswordTextField.text = customView.isSecure ? maskedPassword1 : customView.originalPassword2
        customView.isSpace(textField: customView.secondPasswordTextField, hashPassword: customView.secondPasswordTextField.text!)
    }
}

extension CreatePasswordViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
