//
//  ProfileTextField.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 20.11.2023.
//

import Foundation
import UIKit
import SnapKit

class ProfileTextField: UITextField, UITextFieldDelegate {
    private var placeholderLabel: UILabel!
    private var isError: Bool = false
    private var isPassword: Bool = false
    private var isProfilePLaceholder: Bool = false

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

extension ProfileTextField {
    private func setupBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height + 6, width: frame.width, height: 1)
        bottomLine.backgroundColor = isError ?
        UIColor.red.cgColor :
        UIColor(
            red: 247 / 255,
            green: 246 / 255,
            blue: 249 / 255 ,
            alpha: 1
        ).cgColor
        layer.addSublayer(bottomLine)
        
        let leftInset: CGFloat = 16
        let rightInset: CGFloat = 16
        bottomLine.frame.origin.x = leftInset
        bottomLine.frame.size.width = frame.width - leftInset - rightInset
        bottomLine.frame.origin.y = frame.height + 6
        bottomLine.frame.size.height = 1
    }
    
    private func setupTextFieldPlaceholder() {
        placeholderLabel = UILabel()
        placeholderLabel.numberOfLines = 0
        placeholderLabel.text = "Дата рождения               "
        placeholderLabel.font = UIFont(name: "GothamPro", size: 16)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 16, y: 15)
        addSubview(placeholderLabel)

        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    

    private func setupTextField() {
        font = UIFont(name: "GothamPro-Medium", size: 16)
        textColor = isError ? .red : .black
        setupBorder()
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            self.placeholderLabel.isHidden = true
        } else {
            self.placeholderLabel.isHidden = false
            self.placeholderLabel.font = UIFont(name: "GothamPro-Medium", size: 16)
            self.placeholderLabel.frame.origin = CGPoint(x: 16, y: 15)
            self.setupTextField()
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 7, left: 16, bottom: 0, right: 0))
    }

    override func editingRect (forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 7, left: 16, bottom: 0, right: 0))
    }
}

extension ProfileTextField {
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
}
