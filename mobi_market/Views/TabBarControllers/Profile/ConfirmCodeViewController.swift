//
//  ConfirmCodeViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class ConfirmCodeViewController: UIViewController {
    var time = 60
    var timer = Timer()
    
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
        label.textColor = UIColor(named: "Grey")
        label.textAlignment = .center
        label.text = "Повторный запрос"
        
        return label
    }()
    let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro", size: 16)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Grey")
        label.textAlignment = .center
        label.text = "1:00"
        
        return label
    }()
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont(name: "GothamPro-Bold", size: 28)
        textField.text = "0 0 0 0"
        textField.textColor = UIColor(named: "Black")
        return textField
    }()
    private let repeatButton: UIButton = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setTimer()
    }
}

extension ConfirmCodeViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "Background")
        setProfilePhotoImageView()
        setTitleLabel()
        setNumberTextField()
        setRepeatLabel()
        setTimerLabel()
        setRepeatButton()
        setErrorLabel()
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
    func setNumberTextField() {
        let message = "0 0 0 0"
        numberTextField.text = message
        var attributedString = textFieldTextColorToGrey(numberTextField, message)
        setSpaceBetweenTextField(attributedString)
        numberTextField.attributedText = attributedString
        numberTextField.delegate = self
        
        view.addSubview(numberTextField)
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(16)
        }
    }

    func setRepeatLabel() {
        view.addSubview(repeatLabel)
        repeatLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(numberTextField.snp.bottom).offset(16)
        }
    }
    func setTimerLabel() {
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(repeatLabel.snp.bottom).offset(5.5)
        }
    }
    func setRepeatButton() {
        view.addSubview(repeatButton)
        repeatButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(numberTextField.snp.bottom).offset(24)
        }
    }
    func setErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(repeatButton.snp.bottom).offset(16)
        }
    }
}


extension ConfirmCodeViewController: UITextFieldDelegate {
    func setSpaceBetweenTextField(_ attributedString: NSMutableAttributedString) {
        let kernValue = 3
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length))
    }
    
    func textFieldTextColorToGrey(_ textField: UITextField, _ message: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: message)
        
        let pattern = "0"
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: message, range: NSRange(message.startIndex..., in: message))
        
        for match in matches {
            attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Grey")!, range: match.range)
        }
        
        return attributedString
    }
}

extension ConfirmCodeViewController {
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
    }
    
    @objc func timerCount() {
        time -= 1
        if time >= 0 {
            timerLabel.text = String(format: "0:%0.2d", time)
        }
        
        if time == 0 {
            timer.invalidate()
            timerLabel.isHidden = true
            repeatLabel.isHidden = true
            repeatButton.isHidden = false
        }
    }
}
