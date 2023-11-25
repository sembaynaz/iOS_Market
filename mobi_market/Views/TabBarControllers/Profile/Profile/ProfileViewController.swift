//
//  ProfileViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    let customView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
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
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupView() {
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setChangeInfoButton()
        customView.favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        customView.myProductsButton.addTarget(self, action: #selector(myProductsButtonTapped), for: .touchUpInside)
        customView.logOutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    func setChangeInfoButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customView.changeInfoButton)
        customView.changeInfoButton.addTarget(self, action: #selector(changeInfoButtonTapped), for: .touchUpInside)
    }
}

extension ProfileViewController: AlertDelegate {
    @objc func changeInfoButtonTapped() {
        let vc = UserInfoViewController()
        navigationController?.show(vc, sender: self)
    }
    
    @objc func favoritesButtonTapped() {
        let vc = FavoritesViewController()
        navigationController?.show(vc, sender: self)
    }
    
    @objc func myProductsButtonTapped() {
        let vc = MyProductsViewController()
        navigationController?.show(vc, sender: self)
    }
    
    @objc func logoutButtonTapped() {
        let vc = AlertViewController()
        vc.imageName = "Logout.red"
        vc.activeButtonTitle = "Выйти"
        vc.messageText = "Вы действительно хотите выйти с приложения?"
        vc.cancelButtonTitle = "Отмена"
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
    
    func didAgreeButtonTapped() {
        dismiss(animated: true) {
            let loginViewController = UINavigationController(rootViewController: LoginViewController())
            loginViewController.customize()
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true)
        }
    }
}
