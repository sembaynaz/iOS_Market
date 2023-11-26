//
//  ConfirmCodeViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class ConfirmCodeViewController: UIViewController {
    var isFirstEdit = true
    var time = 60
    var timer = Timer()
    let customView = ConfirmCodeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimer()
        setupUI()
    }
}

extension ConfirmCodeViewController {
    func setupUI() {
        view.addSubview(customView)
        customView.delegate = self
        
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        customView.repeatButton.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)
    }
}

extension ConfirmCodeViewController: ConfirmCodeViewDelegate {
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
    }
    
    @objc func timerCount() {
        time -= 1
        if time >= 0 {
            customView.timerLabel.text = String(format: "0:%0.2d", time)
        }
        
        if time == 0 {
            timer.invalidate()
            customView.timerLabel.isHidden = true
            customView.repeatLabel.isHidden = true
            customView.repeatButton.isHidden = false
            customView.errorLabel.isHidden = false
        } else {
        }
    }
    
    @objc func repeatButtonTapped() {
        time = 60
        setTimer()
        customView.timerLabel.isHidden = false
        customView.repeatLabel.isHidden = false
        customView.repeatButton.isHidden = true
        customView.errorLabel.isHidden = true
    }
    
    func didBeginEditing() {
        customView.isEdit = false
        customView.numberTextField.textColor = UIColor(named: "BlackText")
        customView.numberTextField.text = ""
    }
}
