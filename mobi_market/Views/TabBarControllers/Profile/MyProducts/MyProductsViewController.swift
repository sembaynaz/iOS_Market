//
//  MyProductsViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 17.11.2023.
//

import UIKit

class MyProductsViewController: UIViewController {
    
    var index: Int = 0
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
    private let deleteProductImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DeleteProduct")
        imageView.isHidden = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        checkIsCollectionViewEmpty()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

extension MyProductsViewController {
    func setup() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Мои товары"
        
        setDeleteProductImageView()
        setCollectionView()
        setNavBarLeftButton()
        setEmptyImageView()
        setPopupView()
    }
    
    func setDeleteProductImageView() {
        navigationController?.navigationBar.addSubview(deleteProductImage)
        
        deleteProductImage.snp.makeConstraints { make in
            make.height.equalTo(60 * UIScreen.main.bounds.height / 812)
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
    }
    
    func setPopupView() {
        view.addSubview(popUp)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        popUp.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        popUp.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(644 * UIScreen.main.bounds.height / 812)
            make.leading.trailing.bottom.equalToSuperview()
        }
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
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
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

extension MyProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCardCollectionViewCell.identifier,
            for: indexPath) as! ProductCardCollectionViewCell
        cell.infoButtonHidden = false
        cell.infoDelegate = self
        cell.configure(card: products[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let cellWidth = (availableWidth - 13) / 2
        let cellHeight = 184 * UIScreen.main.bounds.height / 812
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}


extension MyProductsViewController: InfoButtonDelegate {
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: view)
        if !popUp.frame.contains(touchPoint) {
            popUp.isHidden = true
            unblurContainView()
        }
    }
    
    func unblurContainView() {
        blurEffectView?.removeFromSuperlayer()
        blurEffectView = nil
    }
    
    func blurContainView() {
        if blurEffectView == nil {
            blurEffectView = CALayer()
        }
        
        blurEffectView?.backgroundColor = UIColor(red: 19/255, green: 19/255, blue: 19/255, alpha: 0.4).cgColor
        blurEffectView!.frame = view.bounds
        view.layer.addSublayer(blurEffectView!)
        view.bringSubviewToFront(popUp)
    }
    
    func didTapInfoButton(index: Int) {
        self.index = index
        popUp.isHidden = false
        blurContainView()
    }
}

extension MyProductsViewController: AlertDelegate {
    func didAgreeButtonTapped() {
        print(index)
        products.remove(at: index)
        collectionView.reloadData()
        checkIsCollectionViewEmpty()
        
        self.deleteProductImage.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.deleteProductImage.isHidden = true
        }
    }
    
    @objc private func backButtonTapped() { //close vc
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteButtonTapped() {
        popUp.isHidden = true
        unblurContainView()
        
        let vc = AlertViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
        vc.delegate = self
    }
}

extension MyProductsViewController {
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
