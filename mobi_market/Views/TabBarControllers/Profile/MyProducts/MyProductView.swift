//
//  MyProductView.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 26.11.2023.
//

import Foundation
import UIKit

class MyProductView: UIView {
    
    var delegate: InfoButtonDelegate?
    var products: [ProductCard] = [ProductCard(title: "0"), ProductCard(title: "1"), ProductCard(title: "2"), ProductCard(title: "3"), ProductCard(title: "4"), ProductCard(title: "5"), ProductCard(title: "6")]
    var blurEffectView: CALayer?
    
    let popUp: ModalView = {
        let view = ModalView()
        view.isHidden = true
        return view
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
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Icon.arrow-left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Empty")
        imageView.isHidden = true
        return imageView
    }()
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Ой, пусто!"
        label.isHidden = true
        label.font = UIFont(name: "GothamPro-Bold", size: 18)
        label.textColor = UIColor(named: "BlackText")
        return  label
    }()
    let deleteProductImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DeleteProduct")
        imageView.isHidden = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

extension MyProductView {
    func setup() {
        backgroundColor = UIColor(named: "Background")
        
        setDeleteProductImageView()
        setCollectionView()
        setEmptyImageView()
        setPopupView()
    }
    
    func setDeleteProductImageView() {
        
        deleteProductImage.snp.makeConstraints { make in
            make.height.equalTo(60 * UIScreen.main.bounds.height / 812)
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
    }
    
    func setPopupView() {
        addSubview(popUp)
        
        popUp.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(644 * UIScreen.main.bounds.height / 812)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setCollectionView () {
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(24)
        }
    }
    
    func setEmptyImageView() {
        addSubview(emptyImageView)
        addSubview(emptyLabel)
        emptyImageView.snp.makeConstraints { make in
            make.height.equalTo(185 * UIScreen.main.bounds.height / 812)
            make.width.equalTo(168 * UIScreen.main.bounds.width / 375)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(96)
            make.centerX.equalTo(snp.centerX)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(emptyImageView.snp.bottom).offset(44)
        }
    }
}

extension MyProductView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCardCollectionViewCell.identifier,
            for: indexPath) as! ProductCardCollectionViewCell
        cell.infoButtonHidden = false
        cell.infoDelegate = delegate
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
        
    }
}

extension MyProductView {
    func checkIsCollectionViewEmpty() {
        if products.isEmpty {
            emptyImageView.isHidden = false
            emptyLabel.isHidden = false
        } else {
            emptyImageView.isHidden = true
            emptyLabel.isHidden = true
        }
    }
}

extension MyProductView {
    func unblurContainView() {
        blurEffectView?.removeFromSuperlayer()
        blurEffectView = nil
    }
    
    func blurContainView() {
        if blurEffectView == nil {
            blurEffectView = CALayer()
        }
        
        blurEffectView?.backgroundColor = UIColor(red: 19/255, green: 19/255, blue: 19/255, alpha: 0.4).cgColor
        blurEffectView!.frame = bounds
        layer.insertSublayer(blurEffectView!, above: collectionView.layer)
        bringSubviewToFront(popUp)
    }
}
