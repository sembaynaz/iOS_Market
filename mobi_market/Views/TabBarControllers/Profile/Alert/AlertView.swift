//
//  AlertView.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 26.11.2023.
//

import Foundation
import UIKit

class AlertView: UIView {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

extension AlertView {
    func setup() {
        backgroundColor = UIColor(
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
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
            make.horizontalEdges.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.height.equalTo(352 * UIScreen.main.bounds.height / 812)
        }
    }
    func setAgreeButton() {
        backgroundView.addSubview(agreeButton)
        
        agreeButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(24 * UIScreen.main.bounds.height / 812)
            make.height.equalTo(44 * UIScreen.main.bounds.height / 812)
            make.horizontalEdges.equalToSuperview().inset(27.5 * UIScreen.main.bounds.width / 375)
        }
    }
    func setCancelButton() {
        backgroundView.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(agreeButton.snp.bottom).offset(4 * UIScreen.main.bounds.height / 812)
            make.height.equalTo(44 * UIScreen.main.bounds.height / 812)
            make.horizontalEdges.equalToSuperview().inset(27.5 * UIScreen.main.bounds.width / 375)
        }
    }
    func setMessageLabel() {
        backgroundView.addSubview(messageLabel)

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(14 * UIScreen.main.bounds.height / 812)
            make.horizontalEdges.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
        }
    }
    
    func setLogoImage() {
        backgroundView.addSubview(logoImage)

        logoImage.snp.makeConstraints { make in
            make.height.width.equalTo(130 * UIScreen.main.bounds.width / 375)
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.top.equalTo(backgroundView.snp.top).inset(24 * UIScreen.main.bounds.height / 812)
        }
    }
}
