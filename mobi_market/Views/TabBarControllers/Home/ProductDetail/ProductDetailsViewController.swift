//
//  ProductDetailsViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    let customView = ProductDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
    }
}

extension ProductDetailsViewController {
    func setupUi() {
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        customView.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        setNavBarItems()
    }
    
    private func setNavBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView.backButton)
        customView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        if customView.isMyProduct {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customView.changeButton)
            customView.changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        }
    }
}

extension ProductDetailsViewController: AlertDelegate {
    func didAgreeButtonTapped() {
        dismiss(animated: false)
        customView.productInfo.isFavorite = false
        customView.likeButton.setImage( UIImage(named: "Heart"), for: .normal)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func changeButtonTapped() {
        let vc = AddProductViewController()
        vc.contentView.product = self.customView.productInfo
        vc.contentView.isChangeVC = true
        navigationController?.show(vc, sender: self)
    }
    
    @objc private func likeButtonTapped() {
        if !customView.productInfo.isFavorite {
            customView.productInfo.isFavorite = true
            customView.likeButton.setImage( UIImage(named: "HeartFill"), for: .normal)
        } else {
            let vc = AlertViewController()
            vc.imageName = "BigHeart"
            vc.activeButtonTitle = "Удалить"
            vc.messageText = "Вы действительно хотите \nудалить из понравившихся"
            vc.cancelButtonTitle = "Отмена"
            vc.delegate = self
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: false)
            customView.productInfo.isFavorite = true
        }
    }
    
}
