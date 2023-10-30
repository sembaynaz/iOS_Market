//
//  TextField.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 19.10.2023.
//

import UIKit
import SnapKit

class TextField: UITextField, UITextFieldDelegate {
    private var placeholderLabel: UILabel!
    private var isError: Bool = false
    private var isPassword: Bool = false
    
    private let showPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Secure"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        setupTextFieldPlaceholder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
        setupTextFieldPlaceholder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBorder()
    }
}

extension TextField {
    private func setupTextFieldPlaceholder() {
        placeholderLabel = UILabel()
        placeholderLabel.numberOfLines = 0
        placeholderLabel.text = "Введите текст             "
        placeholderLabel.font = UIFont(name: "GothamPro", size: 16)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 0, y: 25)
        addSubview(placeholderLabel)
        
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 0.5)
        bottomLine.backgroundColor = isError ? UIColor.red.cgColor : UIColor(named: "Grey")?.cgColor
        layer.addSublayer(bottomLine)
    }
    
    private func setupTextField() {
        font = UIFont(name: "GothamPro", size: 16)
        textColor = isError ? .red : .black
        setupBorder()
        
        if isPassword {
            textContentType = .password
            isSecureTextEntry = true
            isUserInteractionEnabled = true
            addSubview(showPasswordButton)
            showPasswordButton.addTarget(
                self,
                action: #selector(showPasswordButtonTapped),
                for: .touchUpInside
            )
            
            showPasswordButton.snp.makeConstraints { make in
                make.height.width.equalTo(24)
                make.right.equalTo(0)
                make.bottom.equalTo(-6)
            }
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.frame.origin = CGPoint(x: 0, y: 13)
                self.placeholderLabel.font = UIFont(name: "GothamPro-Medium", size: 14)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.font = UIFont(name: "GothamPro", size: 16)
                self.placeholderLabel.frame.origin = CGPoint(x: 0, y: 25)
                self.isError = false
                self.setupTextField()
            }
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 32, left: 0, bottom: 9, right: 50))
    }
    
    override func editingRect (forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 32, left: 0, bottom: 9, right: 50))
    }
    
    @objc private func showPasswordButtonTapped () {
        isSecureTextEntry.toggle()
        let imageName = isSecureTextEntry ? "Secure" : "Show"
        showPasswordButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension TextField {
    func setPlaceholderText (_ text: String) {
        placeholderLabel.text = text
    }
    
    func isEror (_ isError: Bool) {
        self.isError = isError
        setupTextField()
    }
    
    func setTextToTextField (_ text: String) {
        self.text = text
        textFieldDidChange(self)
    }
    
    func setPasswordTextField (_ isPassword: Bool) {
        self.isPassword  = isPassword
        setupTextField()
        textFieldDidChange(self)
    }
    
    func placesolderToTop() {
        UIView.animate(withDuration: 0.3) {
            self.placeholderLabel.frame.origin = CGPoint(x: 0, y: 13)
            self.placeholderLabel.font = UIFont(name: "GothamPro", size: 12)
        }
    }
}


