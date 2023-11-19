//
//  UserInfoViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class UserInfoViewController: UIViewController {
    
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
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfilePhoto")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let changePhotoButton: UIButton = {
        let button = UIButton()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        button.titleLabel?.font = font
        button.setTitle("Выбрать фотографию", for: .normal)
        button.setTitleColor(UIColor(named: "Blue"), for: .normal)
        return button
    }()
    private let firstBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    private let secondBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    private let nameTextField: TextField = {
        let textFiled = TextField()
        textFiled.setupProfileTextFieled(true)
        textFiled.setPlaceholderText("Имя")
        return textFiled
    }()
    private let secondNameTextField: TextField = {
        let textFiled = TextField()
        textFiled.setupProfileTextFieled(true)
        textFiled.setPlaceholderText("Отчество")
        return textFiled
    }()
    private let lastNameTextField: TextField = {
        let textFiled = TextField()
        textFiled.setupProfileTextFieled(true)
        textFiled.setPlaceholderText("Фамилия")
        return textFiled
    }()
    private let birthDateTextField: TextField = {
        let textFiled = TextField()
        textFiled.setupProfileTextFieled(true)
        textFiled.setPlaceholderText("Дата рождения")
        return textFiled
    }()
    private let phoneNumberButton: UIButton = {
        let button = UIButton()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        button.titleLabel?.font = font
        button.contentHorizontalAlignment = .left
        button.setTitle("Добавить номер", for: .normal)
        button.setTitleColor(UIColor(named: "Blue"), for: .normal)
        return button
    }()
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        label.font = font
        label.textColor = UIColor(named: "Gray")
        label.text = "0(000) 000 000"
        return label
    }()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(
            red: 247 / 255,
            green: 246 / 255,
            blue: 249 / 255,
            alpha: 1
        )
        return view
    }()
    private let emailTextField: TextField = {
        let textFiled = TextField()
        textFiled.setupProfileTextFieled(true)
        textFiled.setPlaceholderText("Email")
        textFiled.font = UIFont(name: "GothamPro-Medium", size: 16)
        return textFiled
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let imageData = UserDefaults.standard.data(forKey: "profilePhoto"),
           let image = UIImage(data: imageData) {
            profilePhotoImageView.image = image
            profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.size.width / 2
            profilePhotoImageView.clipsToBounds = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

extension UserInfoViewController {
    private func setup() {
        view.backgroundColor = UIColor(named: "Background")
        
        setNavBarLeftButton()
        setNavBarRightButton()
        setProfilePhotoImageView()
        setChangePhotoButton()
        setFirstBackgroundView()
        setSecondBackgroundView()
        setNameTextField()
        setLastNameTextField()
        setSecondNameTextField()
        setBirthDateTextField()
        setPhoneNumberButton()
        setPhoneNumberLabel()
        setSeparatorView()
        setEmailTextField()
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
    private func setProfilePhotoImageView() {
        view.addSubview(profilePhotoImageView)
        profilePhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    private func setChangePhotoButton() {
        view.addSubview(changePhotoButton)
        changePhotoButton.addTarget(self, action: #selector(changePhotoButtonTapped), for: .touchUpInside)
        changePhotoButton.snp.makeConstraints { make in
            make.top.equalTo(profilePhotoImageView.snp.bottom).offset(12)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    private func setFirstBackgroundView() {
        view.addSubview(firstBackgroundView)
        firstBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(changePhotoButton.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(179)
        }
    }
    private func setSecondBackgroundView() {
        view.addSubview(secondBackgroundView)
        secondBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(firstBackgroundView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(89)
        }
    }
    private func setNameTextField() {
        firstBackgroundView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(39)
        }
    }
    private func setLastNameTextField() {
        firstBackgroundView.addSubview(lastNameTextField)
        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(39)
        }
    }
    private func setSecondNameTextField() {
        firstBackgroundView.addSubview(secondNameTextField)
        secondNameTextField.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(39)
        }
    }
    private func setBirthDateTextField() {
        firstBackgroundView.addSubview(birthDateTextField)
        birthDateTextField.snp.makeConstraints { make in
            make.top.equalTo(secondNameTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(39)
        }
    }
    private func setPhoneNumberButton() {
        secondBackgroundView.addSubview(phoneNumberButton)
        phoneNumberButton.addTarget(self, action: #selector(phoneNumberButtonTapped), for: .touchUpInside)
        
        phoneNumberButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.height.equalTo(32)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    private func setPhoneNumberLabel() {
        phoneNumberButton.addSubview(phoneNumberLabel)
        phoneNumberLabel.snp.makeConstraints { make in
            make.right.equalTo(phoneNumberButton.snp.right).inset(0)
            make.centerY.equalTo(phoneNumberButton.snp.centerY)
        }
    }
    private func setSeparatorView() {
        secondBackgroundView.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberButton.snp.bottom).offset(6)
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    private func setEmailTextField() {
        secondBackgroundView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(39)
        }
    }
}

extension UserInfoViewController {
    @objc private func backButtonTapped() { //close vc
        //dismiss(animated: false)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func doneButtonTapped() { // close vc and save data
        saveImageToUserDefaults(profilePhotoImageView.image!)
        //dismiss(animated: false)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func phoneNumberButtonTapped() {
        let vc = AddNumberViewController()
        navigationController?.customize()
        navigationItem.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UserInfoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @objc func changePhotoButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profilePhotoImageView.image = image
            profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.size.width / 2
            profilePhotoImageView.clipsToBounds = true
        } else {
            print("Error picking image")
        }
    }

    func saveImageToUserDefaults(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: "profilePhoto")
        }
    }
}
