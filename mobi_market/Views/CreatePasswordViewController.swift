//
//  CreatePasswordViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 28.10.2023.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    var passwordText = ""
    var originalPassword = ""
    var isSecondPasswordEnter: Bool = false
    var isSecure: Bool = true

    let lockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Lock")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Придумайте пароль"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro", size: 16)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Grey")

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 19.2 / label.font.lineHeight
        let attributedString = NSMutableAttributedString(string: "Минимальная длина — 8 символов.\nДля надежности пароль должен \nсодержать буквы и цифры.")
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        label.attributedText = attributedString
        label.textAlignment = .center
        
        return label
    }()
    let nextButton: Button = {
        let button = Button()
        button.setActive(false)
        button.setTitle("Далее", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let firstPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont(name: "GothamPro-Bold", size: 24)
        return textField
    }()
    let secondPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.textAlignment = .center
        textField.font = UIFont(name: "GothamPro-Bold", size: 24)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension CreatePasswordViewController {
    func setShowPasswordButton() {
        let showPasswordButton = UIBarButtonItem(image: UIImage(named: "Secure2"), style: .plain, target: self, action: #selector(showPasswordButtonTapped))
        navigationItem.rightBarButtonItem = showPasswordButton
    }
    
    func setup() {
        view.backgroundColor = .white
        firstPasswordTextField.delegate = self
        secondPasswordTextField.delegate = self
        firstPasswordTextField.becomeFirstResponder()
        
        setLockImage()
        setTitleLabel()
        setDescriptionLabel()
        setFirstPasswordTextField()
        setSecondPasswordTextField()
        setSignupButton()
        setShowPasswordButton()
    }
    func setLockImage() {
        view.addSubview(lockImage)
        lockImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(80)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
        }
    }
    func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(lockImage.snp.bottom).offset(28)
        }
    }
    func setDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    func setFirstPasswordTextField() {
        view.addSubview(firstPasswordTextField)
        firstPasswordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(34)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    func setSecondPasswordTextField() {
        view.addSubview(secondPasswordTextField)
        secondPasswordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(34)
            make.top.equalTo(firstPasswordTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    func setSignupButton() {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(firstPasswordTextField.snp.bottom).offset(91)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}

extension CreatePasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == firstPasswordTextField {
            var hashPassword = String()
            let newChar = string.first
            let offsetToUpdate = passwordText.index(passwordText.startIndex, offsetBy: range.location)
            
            if string == "" {
                passwordText.remove(at: offsetToUpdate)
                return true
            } else {
                passwordText.insert(newChar!, at: offsetToUpdate)
            }
            
            for _ in passwordText.enumerated() {
                hashPassword += "●"
            }
            originalPassword = passwordText
            isSpace(textField: textField, hashPassword: hashPassword)

            if passwordText.contains(where: { $0.isLetter }) && passwordText.contains(where: { $0.isNumber }) &&
                passwordText.count >= 8 {
                nextButton.setActive(true)
            }
            
            return false
        }
        return true
    }
    
    func isSpace(textField: UITextField, hashPassword: String) {
        let kernValue = isSecure ? 12 : 0
        let attributedString = NSMutableAttributedString(string: hashPassword)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length))
        
        textField.attributedText = attributedString
    }
}

extension CreatePasswordViewController {
    @objc func nextButtonTapped() {
        
    }
    
    @objc func showPasswordButtonTapped() {
        isSecure.toggle()
        let passwordLength = originalPassword.count
        let maskedPassword = String(repeating: "●", count: passwordLength)
        firstPasswordTextField.text = isSecure ? maskedPassword : originalPassword
        isSpace(textField: firstPasswordTextField, hashPassword: firstPasswordTextField.text!)
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
