//
//  ProductDetailsViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    private var productImages: [String] = ["image 2", "image 2", "image 2", "image 2"]
    var productInfo = ProductCard()
    var isMyProduct = false
    
    private var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private var currentPage = 0 {
        didSet {
            currentPage = max(0, min(currentPage, productImages.count - 1))
            pageControl.currentPage = currentPage
        }
    }
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    private let costLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Bold", size: 24)
        label.font = font
        label.text = "23 000" + " $"
        label.textColor = UIColor(named: "Blue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Heart"), for: .normal)
        return button
    }()
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 12)
        label.text  = "Нравится: "
        label.textColor = UIColor(named: "Gray")
        return label
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Icon.arrow-left.white"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let changeButton: BarButtonItem = {
        let button = BarButtonItem()
        button.setTitle("Изм.", for: .normal)
        button.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Bold", size: 18)
        label.font = font
        label.text = ""
        label.textColor = UIColor(named: "BlackText")
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro", size: 16)
        label.font = font
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Gray")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 19.2 / label.font.lineHeight
        let attributedString = NSMutableAttributedString(string: "\(String(describing: label.text))")
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        label.attributedText = attributedString
        
        return label
    }()
    private let fullDescription: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        label.font = font
        label.text = "Детальное описание"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "BlackText")
        return label
    }()
    private let fullDescriptionLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro", size: 16)
        label.font = font
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Gray")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 19.2 / label.font.lineHeight
        let attributedString = NSMutableAttributedString(string: "\(String(describing: label.text))")
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configurePageControl()
    }
}

extension ProductDetailsViewController {
    private func setup() {
        view.backgroundColor = .white
        setCollectionView()
        setPageControl()
        setCostLabel()
        setLikeButton()
        setNavBarItems()
        setLikeCountLabel()
        setTitleLabel()
        setDescriptionLabel()
        setFullDescription()
        setFullDescriptionLabel()
    }
    private func setNavBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        if isMyProduct {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: changeButton)
            changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        }
    }
    private func setCollectionView () {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().inset(-125)
            make.bottom.equalToSuperview().offset(-(484+28))
        }
    }
    private func setPageControl() {
        view.addSubview(pageControl)
        pageControl.numberOfPages = productImages.count
        configurePageControl()
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(280)
        }
    }
    private func setCostLabel() {
        view.addSubview(costLabel)
        costLabel.text = productInfo.cost
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(226 * UIScreen.main.bounds.height / 812)
            make.left.equalToSuperview().inset(20)
        }
    }
    private func setLikeButton() {
        view.addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        likeButton.setImage( productInfo.isFavorite ? UIImage(named: "HeartFill"): UIImage(named: "Heart"), for: .normal)
        likeButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.left.equalTo(20)
            make.top.equalTo(costLabel.snp.bottom).offset(8)
        }
    }
    private func setLikeCountLabel() {
        view.addSubview(likeCountLabel)
        likeCountLabel.text = String("Нравится: \(productInfo.likeCount)")
        likeCountLabel.snp.makeConstraints { make in
            make.top.equalTo(costLabel.snp.bottom).offset(14.5)
            make.left.equalTo(likeButton.snp.right).offset(5)
        }
    }
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = productInfo.title
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(17)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    private func setDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.text = productInfo.description
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    private func setFullDescription() {
        view.addSubview(fullDescription)
        fullDescription.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    private func setFullDescriptionLabel() {
        view.addSubview(fullDescriptionLabel)
        fullDescriptionLabel.text = productInfo.fullDescruption
        fullDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(fullDescription.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

extension ProductDetailsViewController {
    private func configurePageControl() {
        let dotSize: CGFloat = 10.0
        let spacing: CGFloat = 10.0
        
        for i in 0 ..< productImages.count {
            let imageView = UIImageView()
            imageView.image = i == pageControl.currentPage ? UIImage(named: "ActiveIndicator") : UIImage(named: "InactiveIndicator")
            imageView.contentMode = .scaleAspectFit
            imageView.frame.size = CGSize(width: 20, height: dotSize)
            imageView.center = CGPoint(x: CGFloat(i) * (dotSize + spacing) + dotSize / 2, y: pageControl.center.y)
            
            view.addSubview(imageView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}


extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                
        let productImageView = UIImageView()
        productImageView.contentMode = .scaleToFill
        productImageView.image = UIImage(named: productImages[indexPath.row])
        cell.backgroundColor = .white
        
        cell.addSubview(productImageView)
        
        productImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = 375 * UIScreen.main.bounds.width / 375
        let cellHeight = 300 * UIScreen.main.bounds.height / 812
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension ProductDetailsViewController: AlertDelegate {
    func didAgreeButtonTapped() {
        dismiss(animated: false)
        productInfo.isFavorite = false
        likeButton.setImage( UIImage(named: "Heart"), for: .normal)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func changeButtonTapped() {
        let vc = AddProductViewController()
        vc.product = self.productInfo
        vc.isChangeVC = true
        navigationController?.show(vc, sender: self)
    }
    
    @objc private func likeButtonTapped() {
        if !productInfo.isFavorite {
            productInfo.isFavorite = true
            likeButton.setImage( UIImage(named: "HeartFill"), for: .normal)
        } else {
            let vc = AlertViewController()
            vc.imageName = "BigHeart"
            vc.activeButtonTitle = "Удалить"
            vc.messageText = "Вы действительно хотите \nудалить из понравившихся"
            vc.cancelButtonTitle = "Отмена"
            vc.delegate = self
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: false)
            productInfo.isFavorite = true
        }
    }
    
}
