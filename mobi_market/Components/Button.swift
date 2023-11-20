//
//  Button.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 19.10.2023.
//

import UIKit

class Button: UIButton {
    private var isActive: Bool = false
    
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
        
        let font = UIFont(name: "GothamPro-Bold", size: 16)
        titleLabel?.font = font
        
        layer.cornerRadius = 23
        backgroundColor = isActive ? UIColor(named: "Blue") : UIColor(named: "Gray")
        setTitleColor(.white, for: .normal)
    }
}

extension Button {
    func setActive(_ isActive: Bool) {
        self.isActive = isActive
        custumize()
    }
}
