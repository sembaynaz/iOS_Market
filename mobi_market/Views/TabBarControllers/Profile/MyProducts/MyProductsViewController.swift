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
        ui()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    func ui() {
        
        view.addSubview(customView)
        customView.delegate = self
        customView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        navigationController?.navigationBar.addSubview(customView.deleteProductImage)
        customView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView.backButton)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        customView.popUp.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        
    }
}


extension MyProductsViewController: InfoButtonDelegate {
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
    
    func didSelectProduct(_ product: ProductCard) {
        let vc = ProductDetailsViewController()
        vc.productInfo = product
        navigationItem.title = ""
        navigationController?.pushViewController(vc, animated: true)
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
}
