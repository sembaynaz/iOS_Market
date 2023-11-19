//
//  TabBarViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private let middleButtonDiameter: CGFloat = 50
    
    private lazy var middleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Plus"), for: .normal)
        button.layer.cornerRadius = middleButtonDiameter / 2
        button.backgroundColor = UIColor(named: "Blue")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        generateTabBar()
        setTabBarAppearance()
        setTabBarHeight(height: 62)
        dropShadow()
        makeUI()
    }
    
    private func makeUI() {
        tabBar.insertSubview(backgroundView, at: 0)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        middleButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.centerX.equalTo(tabBar.snp.centerX)
            make.top.equalTo(tabBar.snp.top).offset(-20)
        }
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: UINavigationController(rootViewController: HomeViewController()),
                title: "Главная",
                image: UIImage(named: "Home"),
                tag: 0,
                isEnabled: true
            ),
            
            generateVC(
                viewController: UINavigationController(rootViewController:  WalletViewController()),
                title: "Кошелек",
                image: UIImage(named: "Wallet"),
                tag: 1,
                isEnabled: true
            ),
            
            generateVC(
                viewController: UINavigationController(rootViewController: AddProductViewController()),
                title: "",
                image: nil,
                tag: 2,
                isEnabled: false
            ),
            
            generateVC(
                viewController: UINavigationController(rootViewController:ChatsViewController()),
                title: "Чаты",
                image: UIImage(named: "Chats"),
                tag: 3,
                isEnabled: true
            ),
            
            generateVC(
                viewController: UINavigationController(rootViewController:ProfileViewController()),
                title: "Профиль",
                image: UIImage(named: "Profile"),
                tag: 4,
                isEnabled: true
            )
        ]
        
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?, tag: Int, isEnabled: Bool) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        viewController.tabBarItem.tag = tag
        viewController.tabBarItem.isEnabled = isEnabled
        return viewController
    }

    private func setTabBarAppearance() {
        tabBar.backgroundColor = .clear
        tabBar.clipsToBounds = true
        tabBar.unselectedItemTintColor = UIColor(red: 214/255, green: 213/255, blue: 219/255, alpha: 1)
        tabBar.tintColor = UIColor(red: 93/255, green: 95/255, blue: 239/255, alpha: 1)
        tabBar.alpha = 1
    }

    private func setTabBarHeight(height: CGFloat) {
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = height
        tabBar.frame = tabBarFrame
    }
    
    func dropShadow(scale: Bool = true) {
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 0.1).cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 20
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shouldRasterize = true
        tabBar.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    @objc func plusButtonTapped() {
        let vc = UINavigationController(rootViewController: AddProductViewController())
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
}
