//
//  ProfileViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    let changeInfoButton: BarButtonItem = {
        let button = BarButtonItem()
        button.setTitle("Изм.", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfilePhoto")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 18)
        label.font = font
        label.text = "Алеся"
        label.textColor = UIColor(named: "BlackText")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let firstBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    let secondBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    let favoritesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Понравившиеся", for: .normal)
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        button.titleLabel?.font = font
        button.contentEdgeInsets = UIEdgeInsets(top: 7, left: 39, bottom: 7, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let myProductsButton: UIButton = {
        let button = UIButton(type: .custom)
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        button.titleLabel?.font = font
        button.setTitle("Мои товары", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 7, left: 39, bottom: 7, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let logOutButton: UIButton = {
        let button = UIButton(type: .custom)
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        button.titleLabel?.font = font
        button.setTitle("Выйти", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 7, left: 39, bottom: 7, right: 0)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let favoritesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Favorites")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let myProductsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MyProducts")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let logOutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logout")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let arrowImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icon.right")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let arrowImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icon.right")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let arrowImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icon.right")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(
            red: 247 / 255,
            green: 246 / 255,
            blue: 249 / 255,
            alpha: 1
        )
        return view
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
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension ProfileViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Профиль"
        
        setChangeInfoButtonTapped()
        setProfilePhotoButton()
        setNameLabel()
        setFirstBackgroundView()
        setSecondBackgroundView()
        setFavoritesButton()
        setSeparatorView()
        setMyProductsButton()
        setLogOutButton()
        
        func setProfilePhotoButton() {
            view.addSubview(profilePhotoImageView)
            profilePhotoImageView.snp.makeConstraints { make in
                make.width.height.equalTo(80)
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
                make.centerX.equalTo(view.snp.centerX)
            }
        }
        
        func setNameLabel() {
            view.addSubview(nameLabel)
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(profilePhotoImageView.snp.bottom).offset(12)
                make.centerX.equalTo(view.snp.centerX)
            }
        }
        
        func setFirstBackgroundView() {
            view.addSubview(firstBackgroundView)
            firstBackgroundView.snp.makeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(24)
                make.horizontalEdges.equalToSuperview().inset(20)
                make.height.equalTo(121)
            }
        }
        
        func setSecondBackgroundView() {
            view.addSubview(secondBackgroundView)
            secondBackgroundView.snp.makeConstraints { make in
                make.top.equalTo(firstBackgroundView.snp.bottom).offset(16)
                make.horizontalEdges.equalToSuperview().inset(20)
                make.height.equalTo(70)
            }
        }
        
        func setFavoritesButton() {
            firstBackgroundView.addSubview(favoritesButton)
            favoritesButton.addSubview(favoritesImageView)
            favoritesButton.addSubview(arrowImageView1)
            favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
    
            favoritesButton.snp.makeConstraints { make in
                make.top.equalTo(firstBackgroundView.snp.top).offset(16)
                make.height.equalTo(38)
                make.horizontalEdges.equalToSuperview().inset(16)
            }
            favoritesImageView.snp.makeConstraints { make in
                make.width.height.equalTo(30)
                make.verticalEdges.equalToSuperview().inset(4)
                make.left.equalToSuperview()
            }
            arrowImageView1.snp.makeConstraints { make in
                make.width.height.equalTo(24)
                make.verticalEdges.equalToSuperview().inset(7)
                make.right.equalToSuperview()
            }
        }
        
        func setSeparatorView() {
            firstBackgroundView.addSubview(separatorView)
            
            separatorView.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(55)
                make.right.equalToSuperview().inset(16)
                make.height.equalTo(1)
                make.top.equalTo(favoritesButton.snp.bottom).offset(6)
            }
        }
        
        func setMyProductsButton() {
            firstBackgroundView.addSubview(myProductsButton)
            myProductsButton.addSubview(myProductsImageView)
            myProductsButton.addSubview(arrowImageView2)
            
            myProductsButton.addTarget(self, action: #selector(myProductsButtonTapped), for: .touchUpInside)
            
            myProductsButton.snp.makeConstraints { make in
                make.top.equalTo(favoritesButton.snp.bottom).offset(13)
                make.height.equalTo(38)
                make.horizontalEdges.equalToSuperview().inset(16)
            }
            myProductsImageView.snp.makeConstraints { make in
                make.width.height.equalTo(30)
                make.verticalEdges.equalToSuperview().inset(4)
                make.left.equalToSuperview()
            }
            arrowImageView2.snp.makeConstraints { make in
                make.width.height.equalTo(24)
                make.verticalEdges.equalToSuperview().inset(7)
                make.right.equalToSuperview()
            }
        }
        
        func setLogOutButton() {
            secondBackgroundView.addSubview(logOutButton)
            logOutButton.addSubview(logOutImageView)
            logOutButton.addSubview(arrowImageView3)
            
            logOutButton.snp.makeConstraints { make in
                make.top.equalTo(secondBackgroundView.snp.top).offset(16)
                make.height.equalTo(38)
                make.horizontalEdges.equalToSuperview().inset(16)
            }
            logOutImageView.snp.makeConstraints { make in
                make.width.height.equalTo(30)
                make.verticalEdges.equalToSuperview().inset(4)
                make.left.equalToSuperview()
            }
            arrowImageView3.snp.makeConstraints { make in
                make.width.height.equalTo(24)
                make.verticalEdges.equalToSuperview().inset(7)
                make.right.equalToSuperview()
            }
        }
        
        func setChangeInfoButtonTapped() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: changeInfoButton)
            changeInfoButton.addTarget(self, action: #selector(changeInfoButtonTapped), for: .touchUpInside)
        }
    }
    
}

extension ProfileViewController {
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
}
