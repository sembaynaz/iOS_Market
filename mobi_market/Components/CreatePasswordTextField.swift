//
//  CreatePassword.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 30.10.2023.
//

import Foundation
import UIKit

class CreatePasswordTextField: UITextField {
    
    private let dotSize: CGSize = CGSize(width: 20, height: 20)
    private let dotSpacing: CGFloat = 12
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightFrame = super.rightViewRect(forBounds: bounds)
        rightFrame.origin.x -= dotSpacing
        return rightFrame
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let dotImage = UIImage(named: "Dot")
        
        let dotImageView = UIImageView(image: dotImage)
        dotImageView.contentMode = .scaleAspectFill
        dotImageView.frame = CGRect(origin: .zero, size: dotSize)
        
        rightView = dotImageView
        rightViewMode = .whileEditing
    }
}
