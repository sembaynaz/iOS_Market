//
//  CreatePasswordViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 28.10.2023.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    var passwordText1 = ""
    var originalPassword1 = ""
    var passwordText2 = ""
    var originalPassword2 = ""
    var isNextButtonTapped: Bool = false
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
        label.textColor = UIColor(named: "Gray")

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
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароли не совпадают"
        label.font = UIFont(name: "GothamPro", size: 15)
        label.textColor = UIColor(named: "Red")
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension CreatePasswordViewController {
    func setup() {
        view.backgroundColor = .white
        firstPasswordTextField.delegate = self
        secondPasswordTextField.delegate = self
        
        setLockImage()
        setTitleLabel()
        setDescriptionLabel()
        setFirstPasswordTextField()
        setSecondPasswordTextField()
        setSignupButton()
        setErrorLabel()
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
        firstPasswordTextField.becomeFirstResponder()
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
    func setErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(nextButton.snp.top).offset(-21)
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
    func setShowPasswordButton() {
        let showPasswordButton = UIBarButtonItem(image: UIImage(named: "Secure2"), style: .plain, target: self, action: #selector(showPasswordButtonTapped))
        navigationItem.rightBarButtonItem = showPasswordButton
    }
}

extension CreatePasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == firstPasswordTextField {
            var hashPassword = ""
            let newChar = string.first
            let offsetToUpdate = passwordText1.index(passwordText1.startIndex, offsetBy: range.location)
            
            if string == "" {
                passwordText1.remove(at: offsetToUpdate)
            } else {
                passwordText1.insert(newChar!, at: offsetToUpdate)
            }
            
            originalPassword1 = passwordText1
            
            if isSecure {
                for _ in passwordText1 {
                    hashPassword += "●"
                }
            } else {
                hashPassword = passwordText1
            }
            
            isSpace(textField: textField, hashPassword: hashPassword)
            
            if originalPassword1.contains(where: { $0.isLetter }) && originalPassword1.contains(where: { $0.isNumber }) &&
                originalPassword1.count >= 8 {
                nextButton.setActive(true)
                nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            } else {
                nextButton.setActive(false)
            }
            
            return false
        }
        
        if textField == secondPasswordTextField {
            var hashPassword = ""
            let newChar = string.first
            let offsetToUpdate = passwordText2.index(passwordText2.startIndex, offsetBy: range.location)
            
            if string == "" {
                passwordText2.remove(at: offsetToUpdate)
            } else {
                passwordText2.insert(newChar!, at: offsetToUpdate)
            }
            
            originalPassword2 = passwordText2
            
            if isSecure {
                for _ in passwordText2 {
                    hashPassword += "●"
                }
            } else {
                hashPassword = passwordText2
            }
            
            if originalPassword2.count >= 8 {
                //doneButtonTapped()
                nextButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
            }
            
            isSpace(textField: textField, hashPassword: hashPassword)
            
            if originalPassword2.contains(where: { $0.isLetter }) && originalPassword2.contains(where: { $0.isNumber }) &&
                originalPassword2.count >= 8 {
                nextButton.setActive(true)
            } else {
                nextButton.setActive(false)
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
        isNextButtonTapped = true
        secondPasswordTextField.isHidden = false
        
        titleLabel.text = "Повторите пароль"
        nextButton.setTitle("Готово", for: .normal)
        
        secondPasswordTextField.becomeFirstResponder()
    }
    
    @objc func doneButtonTapped() {
        if !originalPassword2.isEmpty {
            if originalPassword2 == originalPassword1 {
                errorLabel.isHidden = true
                nextButton.setActive(true)
                
            } else {
                errorLabel.isHidden = false
                nextButton.setActive(false)
            }
        }
    }
    
    @objc func showPasswordButtonTapped() {
        isSecure.toggle()
        
        let passwordLength = originalPassword1.count
        let maskedPassword = String(repeating: "●", count: passwordLength)
        firstPasswordTextField.text = isSecure ? maskedPassword : originalPassword1
        isSpace(textField: firstPasswordTextField, hashPassword: firstPasswordTextField.text!)
        
        let passwordLength1 = originalPassword2.count
        let maskedPassword1 = String(repeating: "●", count: passwordLength1)
        secondPasswordTextField.text = isSecure ? maskedPassword1 : originalPassword2
        isSpace(textField: secondPasswordTextField, hashPassword: secondPasswordTextField.text!)
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
