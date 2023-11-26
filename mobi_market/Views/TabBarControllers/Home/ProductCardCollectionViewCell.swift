//
//  ProductCardCollectionViewCell.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 13.11.2023.
//

import UIKit

protocol ProductCardDelegate: AnyObject {
    func didTapLikeButton(index: Int)
}

protocol InfoButtonDelegate: AnyObject {
    func didTapInfoButton(index: Int)
    func handleTap(_ gesture: UITapGestureRecognizer)
}

class ProductCardCollectionViewCell: UICollectionViewCell {
    var infoButtonHidden = true
    static let identifier = "ProductCard"
    private var currentProductCard: ProductCard!
    weak var delegate: ProductCardDelegate?
    weak var infoDelegate: InfoButtonDelegate?
    var isAdded = false
    var index = 0
    
    let background: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CardImage")
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.text  = "BMW M4 Coupe: A Two-Door"
        label.textColor = UIColor.black
        label.numberOfLines = 2
        return label
    }()
    var costLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.text  = "23 000 $"
        label.textColor = UIColor(named: "Blue")
        return label
    }()
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Heart"), for: .normal)
        return button
    }()
    let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro", size: 12)
        label.text  = "100"
        label.textColor = UIColor(named: "Gray")
        return label
    }()
    let infoButton: UIButton  = { // show pop up
        let button = UIButton()
        button.setImage(UIImage(named: "Info"), for: .normal)
        return button
    }()
    
    func configure(card: ProductCard, index: Int) {
        self.currentProductCard = card
        self.index = index
        cardImageView.image = UIImage(named: card.image)
        titleLabel.text = card.title
        costLabel.text = card.cost
        likeCountLabel.text = String(card.likeCount)
        self.isAdded = card.isFavorite
        setup()
    }
}
//MARK: Constraints
extension ProductCardCollectionViewCell {
    func setup() {
        backgroundColor = .clear
        
        setBackground()
        setCardImageView()
        setTitleLabel()
        setCostLabel()
        setLikeButton()
        setInfoButton()
        setLikeCountLabel()
    }
    func setBackground() {
        addSubview(background)
        dropShadow()
        
        background.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
    }
    
    func setCardImageView() {
        addSubview(cardImageView)
        cardImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(6)
            make.top.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().offset(-93)
        }
    }
    func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cardImageView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().offset(-55)
        }
    }
    func setCostLabel() {
        addSubview(costLabel)
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().offset(-34)
        }
    }
    func setLikeButton() {
        addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(costLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(6)
            make.width.height.equalTo(24)
            make.bottom.equalToSuperview().offset(-6)
        }
    }
    func setLikeCountLabel() {
        addSubview(likeCountLabel)
        likeCountLabel.snp.makeConstraints { make in
            make.left.equalTo(likeButton.snp.right).offset(5)
            make.top.equalTo(costLabel.snp.bottom).offset(10.5)
            make.bottom.equalToSuperview().offset(-12.5)
        }
    }
    func setInfoButton() {
        addSubview(infoButton)
        infoButton.isHidden = infoButtonHidden
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        infoButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.bottom.right.equalToSuperview().offset(-6)
        }
    }
    func dropShadow(scale: Bool = true) {
        background.layer.cornerRadius = 12
        background.layer.masksToBounds = false
        background.layer.shadowColor = UIColor(red: 73/255, green: 73/255, blue: 73/255, alpha: 0.1).cgColor
        background.layer.shadowOffset = CGSize(width: 0, height: 4)
        background.layer.shadowRadius = 20
        background.layer.shadowOpacity = 1
        background.layer.shouldRasterize = true
        background.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}

//MARK: Functionality
extension ProductCardCollectionViewCell {
    @objc func likeButtonTapped() {
        isAdded.toggle()
        
        let photo = isAdded ? UIImage(named: "HeartFill") : UIImage(named: "Heart")
        likeButton.setImage(photo, for: .normal)
        
        let count = isAdded ? currentProductCard.incrementLikeCount() : currentProductCard.decrementLikeCount()
        likeCountLabel.text = String(count)
        
        if isAdded {
            delegate?.didTapLikeButton(index: self.index)
        }
        
        currentProductCard.isFavorite = isAdded
    }
    
    @objc func infoButtonTapped() {
        infoDelegate?.didTapInfoButton(index: self.index)
    }
}
