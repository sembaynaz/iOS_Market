//
//  HomeViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let customView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension HomeViewController {
    func setupUI() {
        view.addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        customView.productDelegate = self
        customView.delegate = self
    }
}

extension HomeViewController: HomeViewDelegate, ProductCardDelegate {
    func didSelectProduct(_ product: ProductCard) {
        print("qqq")
        let vc = ProductDetailsViewController()
        vc.customView.productInfo = product
        navigationItem.title = ""
        navigationController?.show(vc, sender: self)
    }
    
    func didTapLikeButton(index: Int) {
        self.customView.successImageView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.customView.successImageView.isHidden = true
        }
    }
}
