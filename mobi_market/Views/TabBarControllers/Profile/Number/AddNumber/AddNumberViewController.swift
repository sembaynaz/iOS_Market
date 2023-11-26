//
//  AddNumberViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class AddNumberViewController: UIViewController {
    var isFirstEdit = true
    
    let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Phone")
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
        label.text = "Введите номер телефона"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.textColor = UIColor(named: "Black")
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
        let attributedString = NSMutableAttributedString(string: "Мы отправим вам СМС с кодом \nподтверждения")
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        label.attributedText = attributedString
        label.textAlignment = .center
        
        return label
    }()
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont(name: "GothamPro-Bold", size: 28)
        textField.text = "0(000) 000 000"
        textField.textColor = UIColor(named: "Black")
        return textField
    }()
    let nextButton: Button = {
        let button = Button()
        button.setActive(false)
        button.setTitle("Далее", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Данный номер уже зарегистрирован"
        label.font = UIFont(name: "GothamPro", size: 17)
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

extension AddNumberViewController {
    func setup() {
        view.backgroundColor = .white
        setProfilePhotoImageView()
        setTitleLabel()
        setDescriptionLabel()
        setNumberTextField()
        setErrorLabel()
        setNextButton()
    }
    
    func setProfilePhotoImageView() {
        view.addSubview(profilePhotoShadowImageView)
        view.addSubview(profilePhotoImageView)
        
        profilePhotoShadowImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(39)
            make.height.equalTo(80)
            make.width.equalTo(90)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        profilePhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.bottom.equalTo(profilePhotoShadowImageView.snp.bottom).offset(-17)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(profilePhotoImageView.snp.bottom).offset(32)
        }
    }
    func setDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
    }
    func setNumberTextField() {
        numberTextField.delegate = self
        
        let message = "+7(000) 000 00 00"
        numberTextField.text = message
        let attributedString = NSMutableAttributedString(string: message)
        
        let patterns = ["000", "00"]
        let regex = try! NSRegularExpression(pattern: patterns.joined(separator: "|"))
        let matches = regex.matches(in: message, range: NSRange(message.startIndex..., in: message))
        
        for match in matches {
            attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Gray")!, range: match.range)
        }
        
        numberTextField.attributedText = attributedString

        view.addSubview(numberTextField)
        numberTextField.delegate = self
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(33)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(16)
        }
    }
    func setErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(numberTextField.snp.bottom).offset(16)
        }
    }
    func setNextButton() {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(55)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}

extension AddNumberViewController {
    private func formatPhoneNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+X (XXX) XXX XX XX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

extension AddNumberViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isFirstEdit {
            textField.textColor = UIColor(named: "BlackText")
            textField.text = "+7 "
            isFirstEdit = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formatPhoneNumber(number: newString)
        
        if textField.text?.count == 18 {
            nextButton.setActive(true)
            nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        } else {
            nextButton.setActive(false)
        }
        
        return false
    }
}

extension AddNumberViewController {
    @objc func nextButtonTapped() {
        let vc = ConfirmCodeViewController()
        navigationController?.customize()
        navigationItem.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
}

