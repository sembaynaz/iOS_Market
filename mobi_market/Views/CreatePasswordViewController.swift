//
//  CreatePasswordViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 28.10.2023.
//

import UIKit

class CreatePasswordViewController: UIViewController {

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

    let signupButton: Button = {
        let button = Button()
        button.setActive(false)
        button.setTitle("Далее", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.text = "qwesdftgyhujikl"
        textField.textAlignment = .center
        textField.font = UIFont(name: "GothamPro-Bold", size: 24)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.image = UIImage(named: "dot.png")
        passwordTextField.rightView = imageView
        passwordTextField.rightViewMode = .whileEditing
    }
}

extension CreatePasswordViewController {
    func setup() {
        view.backgroundColor = .white
        setLockImage()
        setTitleLabel()
        setDescriptionLabel()
        setPasswordTextField()
        setSignupButton()
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
    func setPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(34)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(28)
        }
    }
    func setSignupButton() {
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(91)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}
