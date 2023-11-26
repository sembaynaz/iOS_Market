//
//  AlertViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 18.11.2023.
//

import UIKit

protocol AlertDelegate: AnyObject {
    func didAgreeButtonTapped()
}

class AlertViewController: UIViewController {
    var imageName = ""
    var messageText = ""
    var activeButtonTitle = ""
    var cancelButtonTitle = ""
    let customVIew = AlertView()
    weak var delegate: AlertDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension AlertViewController {
    func setupUI() {
        view.addSubview(customVIew)
        customVIew.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        customVIew.agreeButton.setTitle("\(activeButtonTitle)", for: .normal)
        customVIew.agreeButton.addTarget(self, action: #selector(agreeButtonTapped), for: .touchUpInside)
        customVIew.cancelButton.setTitle("\(cancelButtonTitle)", for: .normal)
        customVIew.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        customVIew.messageLabel.text = messageText
        customVIew.logoImage.image = UIImage(named: imageName)
    }
}

//MARK: Functionality
extension AlertViewController {
    @objc func cancelButtonTapped() {
        dismiss(animated: false)
    }
    
    @objc func agreeButtonTapped() {
        print("tap")
        delegate?.didAgreeButtonTapped()
        dismiss(animated: false)
    }
}
