//
//  ModalViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 17.11.2023.
//

import UIKit

class ModalView: UIView {
    var viewTranslation = CGPoint(x: 0, y: 0)
    var blurEffectView: UIVisualEffectView?
    var product = ProductCard()
    
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 217 / 255, green: 217 / 255, blue: 217 / 255, alpha: 1)
        view.layer.cornerRadius = 4
        return view
    }()
    let changeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Изменить", for: .normal)
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        button.titleLabel?.font = font
        button.contentEdgeInsets = UIEdgeInsets(top: 7, left: 39, bottom: 7, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(named: "BlackText"), for: .normal)
        return button
    }()
    let deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        button.titleLabel?.font = font
        button.setTitle("Удалить", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 7, left: 39, bottom: 7, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(named: "BlackText"), for: .normal)
        return button
    }()
    let changeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Change")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let deleteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Delete")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func layoutSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 30 * UIScreen.main.bounds.height / 812
        
        setupViews()
    }
}

extension ModalView {
    func setupViews() {
        setGrayView()
        setChangeButton()
        setDeleteButton()
    }
    
    func setGrayView() {
        addSubview(grayView)
        
        grayView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(7.5 * UIScreen.main.bounds.height / 812)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(34)
            make.height.equalTo(5)
        }
    }
    
    func setChangeButton() {
        addSubview(changeButton)
        addSubview(changeImageView)
        
        changeButton.snp.makeConstraints{ make  in
            make.top.equalTo(grayView.snp.bottom).offset(23.5 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(94 * UIScreen.main.bounds.height / 812)
            make.leading.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
    
        changeImageView.snp.makeConstraints{ make in
            make.centerY.equalTo(changeButton.snp.centerY)
            make.height.equalTo(27 * UIScreen.main.bounds.height / 812)
            make.width.equalTo(27 * UIScreen.main.bounds.width / 375)
            make.leading.equalToSuperview().inset(23 * UIScreen.main.bounds.width / 375)
        }
    }
    
    func setDeleteButton() {
        addSubview(deleteButton)
        addSubview(deleteImageView)
        
        deleteButton.snp.makeConstraints{ make  in
            make.top.equalTo(changeButton.snp.bottom).offset(12 * UIScreen.main.bounds.height / 812)
            make.leading.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        deleteImageView.snp.makeConstraints{ make in
            make.centerY.equalTo(deleteButton.snp.centerY)
            make.height.equalTo(27 * UIScreen.main.bounds.height / 812)
            make.width.equalTo(27 * UIScreen.main.bounds.width / 375)
            make.leading.equalToSuperview().inset(23 * UIScreen.main.bounds.width / 375)
        }
    }
}

extension ModalView {
    @objc func deleteButtonTapped() {
        let vc = AlertViewController()
        vc.modalPresentationStyle = .overFullScreen
    }
    
    @objc func changeButtonTapped() {
        print("vcc")
    }
}
