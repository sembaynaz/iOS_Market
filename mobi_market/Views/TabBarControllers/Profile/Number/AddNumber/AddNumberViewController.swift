//
//  AddNumberViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class AddNumberViewController: UIViewController {
    let customView = AddNumberView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension AddNumberViewController {
    func setupUI() {
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        customView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
}

extension AddNumberViewController {
    @objc func nextButtonTapped() {
        let vc = ConfirmCodeViewController()
        navigationController?.customize()
        navigationItem.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }
}

