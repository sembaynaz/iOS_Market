//
//  Button.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 19.10.2023.
//

import UIKit

class Button: UIButton {
    private var isActive: Bool = false
    private var isBarButtonItem: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        custumize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        custumize()
    }
}

extension Button {
    private func custumize() {
        if isBarButtonItem {
            let font = UIFont(name: "GothamPro-Medium", size: 16)
            titleLabel?.font = font
            setTitleColor(UIColor(named: "BlackText"), for: .normal)
            
            layer.cornerRadius = 15
            backgroundColor = UIColor(
                red: 192 / 255,
                green: 192 / 255,
                blue: 192 / 255,
                alpha: 0.2
            )
            contentEdgeInsets = UIEdgeInsets(
                top: 8,
                left: 10,
                bottom: 8,
                right: 10
            )
        } else {
            let font = UIFont(name: "GothamPro-Bold", size: 16)
            titleLabel?.font = font
            
            layer.cornerRadius = 23
            backgroundColor = isActive ? UIColor(named: "Blue") : UIColor(named: "Grey")
            setTitleColor(.white, for: .normal)
        }
    }
}

extension Button {
    func setActive(_ isActive: Bool) {
        self.isActive = isActive
        custumize()
    }
    
    func setBarButtonItem(_ isBarButtonItem: Bool) {
        self.isBarButtonItem = isBarButtonItem
        custumize()
    }
}

/*
 let changeInfoButton: UIButton = {
 let button = UIButton()
 let font = UIFont(name: "GothamPro", size: 16)
 button.titleLabel?.font = font
 button.layer.cornerRadius = 15
 button.backgroundColor = UIColor(named: "Grey")
 button.setTitleColor(UIColor(named: "BlackText"), for: .normal)
 button.setTitle("Изм.", for: .normal)
 button.contentEdgeInsets = UIEdgeInsets(
 top: 8,
 left: 8,
 bottom: 8,
 right: 8
 )
 return button
 }()
 
 let button = UIBarButtonItem(customView: changeInfoButton)
 navigationItem.rightBarButtonItem = UIBarButtonItem(customView: changeInfoButton)
 */
