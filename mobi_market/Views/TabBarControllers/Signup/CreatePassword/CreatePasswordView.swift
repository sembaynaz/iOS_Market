//
//  CreatePasswordView.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 26.11.2023.
//

import Foundation
import UIKit

protocol CreatePasswordViewDelegate: AnyObject {
    func didTapNextButton()
    func didTapDoneButton()
    func didToggleShowPassword()
}

class CreatePasswordView: UIView {
    var passwordText1 = ""
    var originalPassword1 = ""
    var passwordText2 = ""
    var originalPassword2 = ""
    var isSecure: Bool = true
    weak var delegate: CreatePasswordViewDelegate?
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

extension CreatePasswordView {
    func setup() {
        backgroundColor = .white
        firstPasswordTextField.delegate = self
        secondPasswordTextField.delegate = self
        
        setLockImage()
        setTitleLabel()
        setDescriptionLabel()
        setFirstPasswordTextField()
        setSecondPasswordTextField()
        setSignupButton()
        setErrorLabel()
    }
    func setLockImage() {
        addSubview(lockImage)
        lockImage.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.width.height.equalTo(80)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
        }
    }
    func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(lockImage.snp.bottom).offset(28)
        }
    }
    func setDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    func setFirstPasswordTextField() {
        addSubview(firstPasswordTextField)
        firstPasswordTextField.becomeFirstResponder()
        firstPasswordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(34)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    func setSecondPasswordTextField() {
        addSubview(secondPasswordTextField)
        secondPasswordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(34)
            make.top.equalTo(firstPasswordTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    func setErrorLabel() {
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(nextButton.snp.top).offset(-21)
        }
    }
    func setSignupButton() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(firstPasswordTextField.snp.bottom).offset(91)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}

extension CreatePasswordView: UITextFieldDelegate {
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

extension CreatePasswordView {
    @objc private func nextButtonTapped() {
        delegate?.didTapNextButton()
    }
    
    @objc private func doneButtonTapped() {
        delegate?.didTapDoneButton()
    }
    
    @objc private func showPasswordButtonTapped() {
        delegate?.didToggleShowPassword()
    }
}
