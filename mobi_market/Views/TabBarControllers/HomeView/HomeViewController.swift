//
//  HomeViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class HomeViewController: UIViewController {
    var isFavoriteTapped = false
    var products: [ProductCard] = [ProductCard(title: "1"), ProductCard(title: "2"), ProductCard(title: "3"), ProductCard(title: "4")]
    
    var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo_image")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var logoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Nunito", size: 20)
        label.text = "MOBI MARKET"
        return label
    }()
    var successImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Success")
        imageView.isHidden = true
        return imageView
    }()
    var collectionView: UICollectionView = {
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
        collectionView.backgroundColor = UIColor(named: "Background")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = UIColor(named: "Background")
    }
}

extension HomeViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "Background")
        setLogoImageView()
        setCollectionView()
    }
    
    func setCollectionView () {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    func setLogoImageView() {
        navigationController?.navigationBar.addSubview(logoImageView)
        navigationController?.navigationBar.addSubview(logoLabel)
        navigationController?.navigationBar.addSubview(successImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.height.width.equalTo(44)
            make.left.equalToSuperview().inset(20)
        }
        
        logoLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.left).offset(58)
            make.top.equalToSuperview().inset(18)
        }
        
        successImageView.snp.makeConstraints { make in
            make.height.equalTo(60 * UIScreen.main.bounds.height / 812)
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCardCollectionViewCell.identifier,
            for: indexPath) as! ProductCardCollectionViewCell
        
        cell.delegate = self
        cell.configure(card: products[indexPath.row], index: indexPath.row)
       
        return cell
    }
}

extension HomeViewController: ProductCardDelegate {
    func didTapLikeButton(index: Int) {
        self.successImageView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.successImageView.isHidden = true
        }
    }
}
