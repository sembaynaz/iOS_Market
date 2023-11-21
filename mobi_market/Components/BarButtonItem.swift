//
//  BarButtonItem.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 20.11.2023.
//

import Foundation
import UIKit

class BarButtonItem: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        custumize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        custumize()
    }
}

extension BarButtonItem {
    private func custumize() {
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
            top: 8.5,
            left: 10,
            bottom: 8.5,
            right: 10
        )
    }
    
    //private func
}
