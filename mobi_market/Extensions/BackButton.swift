//
//  BackButton.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 20.10.2023.
//

import Foundation
import UIKit

extension UINavigationController {
    func customize(){
        self.navigationBar.backIndicatorImage = UIImage(named: "Icon.arrow-left")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Icon.arrow-left")
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationBar.tintColor = UIColor(named: "Color.backButton")
    }
}
