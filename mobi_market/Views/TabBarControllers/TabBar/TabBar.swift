//
//  TabBar.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 25.11.2023.
//

import Foundation
import UIKit

class TabBar: UITabBar {
    private let middleButtonDiameter: CGFloat = 50
    
    lazy var middleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Plus"), for: .normal)
        button.layer.cornerRadius = middleButtonDiameter / 2
        button.backgroundColor = UIColor(named: "Blue")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeUI()
    }
}

extension TabBar {
    private func makeUI() {
        insertSubview(backgroundView, at: 0)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(middleButton)
        middleButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(snp.top).offset(-20)
        }
        
        setTabBarAppearance()
        dropShadow()
    }
    
    private func setTabBarAppearance() {
        self.backgroundColor = .clear
        self.unselectedItemTintColor = UIColor(red: 214/255, green: 213/255, blue: 219/255, alpha: 1)
        self.tintColor = UIColor(red: 93/255, green: 95/255, blue: 239/255, alpha: 1)
        self.alpha = 1
    }
    
    private func dropShadow(scale: Bool = true) {
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.shadowColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 0.1).cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: -2)
        backgroundView.layer.shadowRadius = 20
        backgroundView.layer.shadowOpacity = 1
        backgroundView.layer.shouldRasterize = true
        backgroundView.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
