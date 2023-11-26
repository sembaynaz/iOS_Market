//
//  FavoritesViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let customView = FavoriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        customView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

//MARK: UI
extension FavoritesViewController {
    func setUI() {
        title = "Понравившиеся"
        
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setNavBarLeftButton()
    }
    
    private func setNavBarLeftButton() {
        view.addSubview(customView.backButton)
        customView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView.backButton)
    }
}

//MARK: Functionality
extension FavoritesViewController: FavoriteViewDelegate {
    @objc private func backButtonTapped() { //close vc
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectProduct(_ product: ProductCard) {
        let vc = ProductDetailsViewController()
        vc.customView.productInfo = product
        navigationItem.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
}
