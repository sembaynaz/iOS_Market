//
//  FavoritesViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    var products: [ProductCard] = []
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 13
        layout.itemSize = CGSize(width: 161, height: 184)
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 24, left: 20, bottom: 20, right: 20)
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            ProductCardCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCardCollectionViewCell.identifier
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Icon.arrow-left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Empty")
        imageView.isHidden = true
        return imageView
    }()
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Ой, пусто!"
        label.isHidden = true
        label.font = UIFont(name: "GothamPro-Bold", size: 18)
        label.textColor = UIColor(named: "BlackText")
        return  label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        if products.isEmpty {
            emptyImageView.isHidden = false
            emptyLabel.isHidden = false
        } else {
            emptyImageView.isHidden = true
            emptyLabel.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

extension FavoritesViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Понравившиеся"
        
        setCollectionView()
        setNavBarLeftButton()
        setEmptyImageView()
    }
    
    private func setNavBarLeftButton() {
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func setCollectionView () {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func setEmptyImageView() {
        view.addSubview(emptyImageView)
        view.addSubview(emptyLabel)
        emptyImageView.snp.makeConstraints { make in
            make.height.equalTo(185 * UIScreen.main.bounds.height / 812)
            make.width.equalTo(168 * UIScreen.main.bounds.width / 375)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(96)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(emptyImageView.snp.bottom).offset(44)
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCardCollectionViewCell.identifier,
            for: indexPath) as! ProductCardCollectionViewCell
        cell.configure(card: products[indexPath.row], index: indexPath.row)

        return cell
    }
}


extension FavoritesViewController {
    @objc private func backButtonTapped() { //close vc
        navigationController?.popViewController(animated: true)
    }
}
