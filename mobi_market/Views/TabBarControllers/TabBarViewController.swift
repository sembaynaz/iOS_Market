//
//  TabBarViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    let customTabBar = TabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        generateTabBar()
        setTabBarHeight(height: 62)
        self.setValue(customTabBar, forKey: "tabBar")
        customTabBar.middleButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
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

    private func setTabBarHeight(height: CGFloat) {
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = height
        tabBar.frame = tabBarFrame
    }
    
    @objc func plusButtonTapped() {
        do {
            let vc = UINavigationController(rootViewController: AddProductViewController())
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: false)
            print("vc")
        } catch {
            print("Error: \(error)")
        }
    }
}
