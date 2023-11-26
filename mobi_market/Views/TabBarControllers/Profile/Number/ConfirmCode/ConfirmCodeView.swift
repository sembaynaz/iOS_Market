//
//  ConfirmCodeView.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 26.11.2023.
//

import Foundation
import UIKit

protocol ConfirmCodeViewDelegate: AnyObject {
    func didBeginEditing()
}

class ConfirmCodeView: UIView {
    var isEdit = true
    weak var delegate: ConfirmCodeViewDelegate?
    
    let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let profilePhotoShadowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Shadow")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код из СМС"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.textColor = UIColor(named: "Black")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let repeatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro", size: 16)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Gray")
        label.textAlignment = .center
        label.text = "Повторный запрос"
        
        return label
    }()
    let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro", size: 16)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Gray")
        label.textAlignment = .center
        label.text = "1:00"
        
        return label
    }()
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont(name: "GothamPro-Bold", size: 28)
        textField.text = "0 0 0 0"
        textField.textColor = UIColor(named: "Gray")
        return textField
    }()
    let repeatButton: UIButton = {
        let button = UIButton()
        let font = UIFont(name: "GothamPro-Medium", size: 17)
        button.titleLabel?.font = font
        button.contentHorizontalAlignment = .left
        button.setTitle("Отправить код еще раз", for: .normal)
        button.setTitleColor(UIColor(named: "Blue"), for: .normal)
        button.isHidden = true
        return button
    }()
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Неверный код"
        label.font = UIFont(name: "GothamPro-Medium", size: 17)
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

extension ConfirmCodeView {
    func setup() {
        backgroundColor = UIColor(named: "Background")
        setProfilePhotoImageView()
        setTitleLabel()
        setNumberTextField()
        setRepeatLabel()
        setTimerLabel()
        setRepeatButton()
        setErrorLabel()
    }
    func setProfilePhotoImageView() {
        addSubview(profilePhotoShadowImageView)
        addSubview(profilePhotoImageView)
        
        profilePhotoShadowImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(39)
            make.height.equalTo(80)
            make.width.equalTo(90)
            make.centerX.equalTo(snp.centerX)
        }
        
        profilePhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.bottom.equalTo(profilePhotoShadowImageView.snp.bottom).offset(-17)
            make.centerX.equalTo(snp.centerX)
        }
    }
    func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(profilePhotoImageView.snp.bottom).offset(32)
        }
    }
    func setNumberTextField() {
        numberTextField.delegate = self
        //numberTextField.becomeFirstResponder()
        addSubview(numberTextField)
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(snp.horizontalEdges).inset(16)
        }
    }
    
    func setRepeatLabel() {
        addSubview(repeatLabel)
        repeatLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(numberTextField.snp.bottom).offset(16)
        }
    }
    func setTimerLabel() {
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(repeatLabel.snp.bottom).offset(5.5)
        }
    }
    func setRepeatButton() {
        addSubview(repeatButton)
        repeatButton.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(numberTextField.snp.bottom).offset(24)
        }
    }
    func setErrorLabel() {
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(repeatButton.snp.bottom).offset(16)
        }
    }
}


extension ConfirmCodeView: UITextFieldDelegate {
    func setSpaceBetweenTextField(_ attributedString: NSMutableAttributedString) {
        let kernValue: CGFloat = 10.0
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length))
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBeginEditing()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacterSet = CharacterSet.decimalDigits
        let replacementStringCharacterSet = CharacterSet(charactersIn: string)
        let isNumeric = allowedCharacterSet.isSuperset(of: replacementStringCharacterSet)
        
        let newLength = textField.text!.count + string.count - range.length
        if newLength > 4 {
            return false
        }
        
        let mutableAttributedString = NSMutableAttributedString(string: textField.text ?? "")
        setSpaceBetweenTextField(mutableAttributedString)
        textField.attributedText = mutableAttributedString
        textField.textColor = UIColor(named: "BlackText")
        
        return true
    }
}
