//
//  MyProductsViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 17.11.2023.
//

import UIKit

class MyProductsViewController: UIViewController {
    var index: Int = 0
    let customView = MyProductView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои товары"
        
        setupUi()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupUi() {
        
        view.addSubview(customView)
        customView.delegate = self
        customView.homeDelegate = self
        customView.productDelegate = self
        
        customView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        setupNavButtons()
        setupPopupView()
    }
    
    func setupNavButtons() {
        navigationController?.navigationBar.addSubview(customView.deleteProductImage)
        navigationController?.navigationBar.addSubview(customView.successImageView)
        customView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView.backButton)
    }
    
    func setupPopupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        customView.popUp.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        customView.popUp.changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
    }
}


extension MyProductsViewController: InfoButtonDelegate, MyProductViewDelegate, ProductCardDelegate {
    func didTapLikeButton(index: Int) {
        self.customView.successImageView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.customView.successImageView.isHidden = true
        }
    }

    func didSelectProduct(_ product: ProductCard) {
        let vc = ProductDetailsViewController()
        vc.customView.productInfo = product
        vc.isMyProduct = true
        navigationItem.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: view)
        if !customView.popUp.frame.contains(touchPoint) {
            customView.popUp.isHidden = true
            customView.unblurContainView()
        }
    }
    
    func didTapInfoButton(index: Int) {
        self.index = index
        
        customView.popUp.isHidden = false
        customView.blurContainView()
    }
}

extension MyProductsViewController: AlertDelegate {
    func didAgreeButtonTapped() {
        customView.products.remove(at: index)
        customView.collectionView.reloadData()
        customView.checkIsCollectionViewEmpty()
        
        customView.deleteProductImage.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.customView.deleteProductImage.isHidden = true
        }
    }
    
    @objc private func backButtonTapped() { //close vc
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteButtonTapped() {
        customView.popUp.isHidden = true
        customView.unblurContainView()
        
        let vc = AlertViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.activeButtonTitle = "Удалить"
        vc.imageName = "Trash"
        vc.cancelButtonTitle = "Отмена"
        vc.messageText = "Вы действительно хотите \nудалить данный товар?"
        present(vc, animated: false)
        vc.delegate = self
    }
    
    @objc func changeButtonTapped() {
        let vc = AddProductViewController()
        vc.product = self.customView.products[index]
        vc.isChangeVC = true
        navigationController?.show(vc, sender: self)
        customView.popUp.isHidden = true
        customView.unblurContainView()
    }
}
