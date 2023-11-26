//
//  AddProductViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 27.11.2023.
//

import Foundation
import UIKit

class AddProductViewController: UIViewController {
    let contentView = AddProductView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension AddProductViewController {
    func setupUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setNavBarLeftButton()
        setNavBarRightButton()
        
        contentView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
    }
    
    private func setNavBarLeftButton() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: contentView.backButton)
    }
    private func setNavBarRightButton() {
        contentView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: contentView.doneButton)
    }
}

extension AddProductViewController: AlertDelegate {
    @objc private func backButtonTapped() {
        if contentView.nameTextView.text == contentView.namePlaceholder &&
            contentView.costTextView.text == contentView.costPlaceholder &&
            contentView.descriptionTextView.text == contentView.descriptionPlaceholder &&
            contentView.fullDescriptionTextView.text == contentView.fullDescriptionPlaceholder {
            if contentView.isChangeVC {
                navigationController?.popViewController(animated: true)
            } else {
                dismiss(animated: true)
            }
        } else {
            let vc = AlertViewController()
            vc.imageName = "Remove"
            vc.activeButtonTitle = "Да"
            vc.messageText = "Вы действительно хотите \nотменить добавление товара?"
            vc.cancelButtonTitle = "Нет"
            vc.delegate = self
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: false)
        }
        
    }
    
    func didAgreeButtonTapped() {
        if contentView.isChangeVC {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    
    @objc private func doneButtonTapped() {
        if contentView.nameTextView.text == contentView.namePlaceholder &&
            contentView.costTextView.text == contentView.costPlaceholder &&
            contentView.descriptionTextView.text == contentView.descriptionPlaceholder &&
            contentView.fullDescriptionTextView.text == contentView.fullDescriptionPlaceholder {
            
            contentView.isErrorTextField(textView: contentView.nameTextView, isError: true)
            contentView.isErrorTextField(textView: contentView.costTextView, isError: true)
            contentView.isErrorTextField(textView: contentView.descriptionTextView, isError: true)
            contentView.isErrorTextField(textView: contentView.fullDescriptionTextView, isError: true)
            contentView.setDefaultPhotoButtonStyle(isError: true)
            
        } else {
            if contentView.isChangeVC {
                navigationController?.popViewController(animated: true)
            } else {
                dismiss(animated: true)
            }
        }
    }
}

//MARK: SelectImage
extension AddProductViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @objc func photoButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            contentView.productImages.append(image)
            contentView.collectionView.reloadData()
        } else {
            print("Error picking image")
        }
    }
}
