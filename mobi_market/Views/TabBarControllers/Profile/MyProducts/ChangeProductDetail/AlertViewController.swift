//
//  AlertViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 18.11.2023.
//

import UIKit
protocol AlertDelegate: AnyObject {
    func didAgreeButtonTapped()
}

class AlertViewController: UIViewController {
    var imageName = ""
    var messageText = ""
    var activeButtonTitle = ""
    var cancelButtonTitle = ""
    weak var delegate: AlertDelegate?
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        return view
    }()
    
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Trash")
        return image
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 18)
        label.font = font
        label.textColor = UIColor(named: "BlackText")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Вы действительно хотите \nудалить данный товар?"
        return label
    }()
    
    let agreeButton: Button = {
        let button = Button()
        button.setActive(true)
        button.setTitle("Удалить", for: .normal)
        return button
    }()
    let cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        let font = UIFont(name: "GothamPro-Bold", size: 16)
        button.titleLabel?.font = font
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(UIColor(named: "BlackText"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension AlertViewController {
    func setup() {
        view.backgroundColor = UIColor(
            red: 19/255,
            green: 19/255,
            blue: 19/255,
            alpha: 0.4
        )

        setBackgroundView()
        setLogoImage()
        setMessageLabel()
        setAgreeButton()
        setCancelButton()
    }
    
    func setBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
            make.horizontalEdges.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.height.equalTo(352 * UIScreen.main.bounds.height / 812)
        }
    }
    func setAgreeButton() {
        backgroundView.addSubview(agreeButton)
        
        agreeButton.setTitle("\(activeButtonTitle)", for: .normal)
        agreeButton.addTarget(self, action: #selector(agreeButtonTapped), for: .touchUpInside)
        agreeButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(24 * UIScreen.main.bounds.height / 812)
            make.height.equalTo(44 * UIScreen.main.bounds.height / 812)
            make.horizontalEdges.equalToSuperview().inset(27.5 * UIScreen.main.bounds.width / 375)
        }
    }
    func setCancelButton() {
        backgroundView.addSubview(cancelButton)
        cancelButton.setTitle("\(cancelButtonTitle)", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(agreeButton.snp.bottom).offset(4 * UIScreen.main.bounds.height / 812)
            make.height.equalTo(44 * UIScreen.main.bounds.height / 812)
            make.horizontalEdges.equalToSuperview().inset(27.5 * UIScreen.main.bounds.width / 375)
        }
    }
    func setMessageLabel() {
        backgroundView.addSubview(messageLabel)
        messageLabel.text = messageText
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(14 * UIScreen.main.bounds.height / 812)
            make.horizontalEdges.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
        }
    }
    
    func setLogoImage() {
        backgroundView.addSubview(logoImage)
        logoImage.image = UIImage(named: imageName)
        logoImage.snp.makeConstraints { make in
            make.height.width.equalTo(130 * UIScreen.main.bounds.width / 375)
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.top.equalTo(backgroundView.snp.top).inset(24 * UIScreen.main.bounds.height / 812)
        }
    }
}

    //MARK: Functionality
extension AlertViewController {
    @objc func cancelButtonTapped() {
        dismiss(animated: false)
    }
    
    @objc func agreeButtonTapped() {
        print("tap")
        delegate?.didAgreeButtonTapped()
        dismiss(animated: false)
    }
}
