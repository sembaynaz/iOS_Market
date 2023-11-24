//
//  AddProductViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 23.11.2023.
//

import UIKit

class AddProductViewController: UIViewController {
    let contentView = AddProductView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setFunctuanality()
    }
    
    func setupViews() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func setFunctuanality() {
        contentView.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        
        
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: contentView.backButton)
        
        contentView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: contentView.doneButton)
    }
}

extension AddProductViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @objc func photoButtonTapped() {
        print("tap")
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
            //contentView.collectionView.re
        } else {
            print("Error picking image")
        }
    }
}

extension AddProductViewController: AlertDelegate {
    @objc private func backButtonTapped() {
        if contentView.nameTextView.text == contentView.namePlaceholder &&
            contentView.costTextView.text == contentView.costPlaceholder &&
            contentView.descriptionTextView.text == contentView.descriptionPlaceholder &&
            contentView.fullDescriptionTextView.text == contentView.fullDescriptionPlaceholder {
            dismiss(animated: true)
        } else {
            let vc = AlertViewController()
            vc.imageName = "Remove"
            vc.activeButtonTitle = "Да"
            vc.messageText = contentView.isChangeVC ? "Вы действительно хотите \nотменить изменение товара?" : "Вы действительно хотите \nотменить добавление товара?"
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
            dismiss(animated: false)
            
            self.dismiss(animated: false)
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
