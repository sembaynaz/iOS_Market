//
//  HomeView.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 26.11.2023.
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject {
    func didSelectProduct(_ product: ProductCard)
}

class HomeView: UIView {
    var isFavoriteTapped = false
    weak var delegate: HomeViewDelegate?
    weak var productDelegate: ProductCardDelegate?
    
    var products: [ProductCard] = [ProductCard(), ProductCard(), ProductCard(), ProductCard(), ProductCard(), ProductCard(), ProductCard()]
    
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
        layout.minimumLineSpacing = 12
        
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
        collectionView.contentInset.left = 24
        collectionView.contentInset.right = 24
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
}

extension HomeView {
    func setup() {
        backgroundColor = UIColor(named: "Background")
        setLogoImageView()
        setCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setCollectionView () {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    func setLogoImageView() {
        addSubview(logoImageView)
        addSubview(logoLabel)
        addSubview(successImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(52)
            make.height.width.equalTo(44)
            make.left.equalToSuperview().inset(23)
        }
        
        logoLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(8)
            make.top.equalToSuperview().inset(17 + 44)
        }
        
        successImageView.snp.makeConstraints { make in
            make.height.equalTo(60 * UIScreen.main.bounds.height / 812)
            make.top.equalToSuperview().inset(52)
            make.horizontalEdges.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCardCollectionViewCell.identifier,
            for: indexPath) as! ProductCardCollectionViewCell
        
        cell.delegate = productDelegate
        cell.configure(card: products[indexPath.row], index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let cellWidth = (availableWidth - 13) / 2
        let cellHeight = 184 * UIScreen.main.bounds.height / 812
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        print("tap")
        delegate?.didSelectProduct(selectedProduct)
    }
    
}
