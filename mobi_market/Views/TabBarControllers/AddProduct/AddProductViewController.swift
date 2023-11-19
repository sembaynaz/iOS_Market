//
//  PlusViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class AddProductViewController: UIViewController {
    private let backButton: Button = {
        let button = Button()
        button.setBarButtonItem(true)
        button.setTitle("Отмена", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let doneButton: Button = {
        let button = Button()
        button.setBarButtonItem(true)
        button.setTitle("Готово", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let photoButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private let costTextField: TextField = {
        let textField = TextField()
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 12
        textField.setupProfileTextFieled(true)
        textField.setPlaceholderText("Цена")
        textField.font = UIFont(name: "GothamPro", size: 16)
        return textField
    }()
    private let nameTextField: TextField = {
        let textField = TextField()
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 12
        textField.setupProfileTextFieled(true)
        textField.setPlaceholderText("Название")
        return textField
    }()
    private let descriptionTextField: TextField = {
        let textField = TextField()
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 12
        textField.setupProfileTextFieled(true)
        textField.setPlaceholderText("Краткое описание")
        return textField
    }()
    private let fullDescriptionTextField: TextField = {
        let textField = TextField()
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 12
        textField.setupProfileTextFieled(true)
        textField.setPlaceholderText("Детальное описание")
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

extension AddProductViewController {
    private func setup() {
        view.backgroundColor = UIColor(named: "Background")
        
        setNavBarLeftButton()
        setNavBarRightButton()
        setCostTextField()
        setNameTextField()
        setDescriptionTextField()
        setFullDescriptionTextField()
    }
    private func setNavBarLeftButton() {
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    private func setNavBarRightButton() {
        view.addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
    private func setCostTextField() {
        view.addSubview(costTextField)
        costTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(148)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40 * UIScreen.main.bounds.height / 812)
        }
    }
    private func setNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(costTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40 * UIScreen.main.bounds.height / 812)
        }
    }
    private func setDescriptionTextField() {
        view.addSubview(descriptionTextField)
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40 * UIScreen.main.bounds.height / 812)
        }
    }
    private func setFullDescriptionTextField() {
        view.addSubview(fullDescriptionTextField)
        fullDescriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40 * UIScreen.main.bounds.height / 812)
        }
    }
    
}

extension AddProductViewController {
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true)
    }
}
