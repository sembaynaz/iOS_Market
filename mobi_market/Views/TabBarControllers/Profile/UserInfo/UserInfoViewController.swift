//
//  UserInfoViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class UserInfoViewController: UIViewController {
    var userInfo = UserInfo()
    let customView = UserInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let imageData = UserDefaults.standard.data(forKey: "profilePhoto"),
           let image = UIImage(data: imageData) {
            customView.profilePhotoImageView.image = image
            customView.profilePhotoImageView.layer.cornerRadius = customView.profilePhotoImageView.frame.size.width / 2
            customView.profilePhotoImageView.clipsToBounds = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

extension UserInfoViewController {
    func setupView() {
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setNavBarLeftButton()
        setNavBarRightButton()
        setActions()
    }
    
    func setActions() {
        customView.changePhotoButton.addTarget(self, action: #selector(changePhotoButtonTapped), for: .touchUpInside)
        customView.phoneNumberButton.addTarget(self, action: #selector(phoneNumberButtonTapped), for: .touchUpInside)
    }
    
    private func setNavBarLeftButton() {
        view.addSubview(customView.backButton)
        customView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView.backButton)
    }
    private func setNavBarRightButton() {
        view.addSubview(customView.doneButton)
        customView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customView.doneButton)
    }
}

extension UserInfoViewController {
    @objc private func backButtonTapped() { //close vc
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func doneButtonTapped() { // close vc and save data
        saveImageToUserDefaults(customView.profilePhotoImageView.image!)
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

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            customView.profilePhotoImageView.image = image
            customView.profilePhotoImageView.layer.cornerRadius = customView.profilePhotoImageView.frame.size.width / 2
            customView.profilePhotoImageView.clipsToBounds = true
        } else {
            print("Error picking image")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    func saveImageToUserDefaults(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: "profilePhoto")
        }
    }
}

extension UserInfoViewController {
    func loadUserInfoFromUserDefaults() -> UserInfo? {
        let userDefaults = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedData = userDefaults.data(forKey: "userInfoKey"),
           let userInfo = try? decoder.decode(UserInfo.self, from: savedData) {
            return userInfo
        }
        return nil
    }
}
