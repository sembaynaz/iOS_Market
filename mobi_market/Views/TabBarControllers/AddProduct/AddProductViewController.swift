//
//  PlusViewController.swift
//  mobi_market
//
//  Created by Nazerke Sembay on 02.11.2023.
//

import UIKit

class AddProductViewController: UIViewController {
    var product = ProductCard()
    var productImages: [UIImage] = []
    let namePlaceholder = "Название"
    let costPlaceholder = "Цена"
    let descriptionPlaceholder = "Краткое описание"
    let fullDescriptionPlaceholder = "Детальное описание"
    var isChangeVC = false
    
    private let backButton: BarButtonItem = {
        let button = BarButtonItem()
        button.setTitle("Отмена", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let doneButton: BarButtonItem = {
        let button = BarButtonItem()
        button.setTitle("Готово", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let photoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    private let photoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 12
        button.backgroundColor = .clear
        return button
    }()
    private let costTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
        textView.layer.cornerRadius = 12
        textView.textColor = .lightGray
        //textView.font = UIFont(name: "Gothampro", size: 16)
        textView.text = "Цена"
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.clear.cgColor
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        textView.attributedText = NSAttributedString(string: textView.text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let font = UIFont(name: "Gothampro", size: 16)
        textView.font = font
        
        return textView
    }()
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
        textView.layer.cornerRadius = 12
        textView.textColor = .lightGray
 //       textView.font = UIFont(name: "Gothampro", size: 16)
        textView.text = "Название"
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.clear.cgColor
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        textView.attributedText = NSAttributedString(string: textView.text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let font = UIFont(name: "Gothampro", size: 16)
        textView.font = font
        
        return textView
    }()
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
        textView.layer.cornerRadius = 12
        textView.textColor = .lightGray
//        textView.font = UIFont(name: "Gothampro", size: 16)
        textView.text = "Краткое описание"
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.clear.cgColor

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        textView.attributedText = NSAttributedString(string: textView.text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let font = UIFont(name: "Gothampro", size: 16)
        textView.font = font
        
        return textView
    }()
    private let fullDescriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
        textView.layer.cornerRadius = 12
        textView.textColor = .lightGray
        textView.text = "Детальное описание"
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.clear.cgColor
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        textView.attributedText = NSAttributedString(string: textView.text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let font = UIFont(name: "Gothampro", size: 16)
        textView.font = font
        
        return textView
    }()
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor(named: "Background")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

extension AddProductViewController {
    private func setup() {
        view.backgroundColor = UIColor(named: "Background")
        
        setNavBarLeftButton()
        setNavBarRightButton()
        setPhotoButton()
        setCostTextView()
        setNameTextView()
        setDescriptionTextView()
        setFullDescriptionTextView()
        setCollectionView()
    }
    private func setPhotoButton() {
        view.addSubview(photoView)
        view.addSubview(photoButton)
        
        setDefaultPhotoButtonStyle(isError: false)
        photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        
        photoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(96)
            make.width.equalTo(76)
        }
        photoButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(96)
            make.width.equalTo(76)
        }
    }
    func setCollectionView () {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(photoView.snp.right)
            make.right.equalToSuperview()
            make.bottom.equalTo(costTextView.snp.top).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
    }
    private func setNavBarLeftButton() {
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    private func setNavBarRightButton() {
        view.addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
    private func setCostTextView() {
        view.addSubview(costTextView)
        costTextView.delegate = self
        costTextView.text = product.cost
        
        adjustUITextViewHeight(arg: costTextView)
        costTextView.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(26)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    private func setNameTextView() {
        view.addSubview(nameTextView)
        nameTextView.delegate = self
        nameTextView.text = product.title
        
        adjustUITextViewHeight(arg: nameTextView)
        nameTextView.snp.makeConstraints { make in
            make.top.equalTo(costTextView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
    }
    private func setDescriptionTextView() {
        view.addSubview(descriptionTextView)
        descriptionTextView.delegate = self
        descriptionTextView.text = product.description
        
        adjustUITextViewHeight(arg: descriptionTextView)
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    private func setFullDescriptionTextView() {
        view.addSubview(fullDescriptionTextView)
        fullDescriptionTextView.delegate = self
        fullDescriptionTextView.text = product.fullDescruption
        
        adjustUITextViewHeight(arg: fullDescriptionTextView)
        fullDescriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
}

extension AddProductViewController: AlertDelegate {
    @objc private func backButtonTapped() {
        if nameTextView.text == namePlaceholder &&
            costTextView.text == costPlaceholder &&
            descriptionTextView.text == descriptionPlaceholder &&
            fullDescriptionTextView.text == fullDescriptionPlaceholder {
            dismiss(animated: true)
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
        dismiss(animated: false)
        
        self.dismiss(animated: false)
    }
    
    
    @objc private func doneButtonTapped() {
        if nameTextView.text == namePlaceholder &&
            costTextView.text == costPlaceholder &&
            descriptionTextView.text == descriptionPlaceholder &&
            fullDescriptionTextView.text == fullDescriptionPlaceholder {
            
            isErrorTextField(textView: nameTextView, isError: true)
            isErrorTextField(textView: costTextView, isError: true)
            isErrorTextField(textView: descriptionTextView, isError: true)
            isErrorTextField(textView: fullDescriptionTextView, isError: true)
            setDefaultPhotoButtonStyle(isError: true)
            
        } else {
            dismiss(animated: true)
        }
    }
}

extension AddProductViewController {
    private func setDefaultPhotoButtonStyle(isError: Bool) {
        let imageView = isError ? UIImageView(image: UIImage(named: "Image_add_error")) : UIImageView(image: UIImage(named: "Image_add"))
        imageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "GothamPro-Medium", size: 12)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = "Добавить \nфото"
        titleLabel.textColor = isError ? .red : UIColor(named: "Blue")
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 6
        
        photoView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: photoView.centerYAnchor)
        ])
        
        photoView.backgroundColor = .white
        photoView.layer.cornerRadius = 12
        photoView.layer.borderWidth = isError ? 1 : 0
        photoView.layer.borderColor = isError ? UIColor.red.cgColor : UIColor.clear.cgColor
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
            productImages.append(image)
            collectionView.reloadData()
        } else {
            print("Error picking image")
        }
    }
}


extension AddProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count // Assuming you have 5 images in your productImages array
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.subviews.forEach { $0.removeFromSuperview() }
        
        let productImageView = UIImageView()
        productImageView.contentMode = .scaleAspectFit
        productImageView.layer.cornerRadius = 12
        productImageView.clipsToBounds = true
        productImageView.image = productImages[indexPath.row]
        
        cell.addSubview(productImageView)
        
        productImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = 76 * UIScreen.main.bounds.width / 375
        let cellHeight = 96 * UIScreen.main.bounds.height / 812
        
        let horizontalSpacing: CGFloat = 6
        let verticalSpacing: CGFloat = 10
        
        let adjustedCellWidth = cellWidth - horizontalSpacing
        let adjustedCellHeight = cellHeight - verticalSpacing
        
        return CGSize(width: adjustedCellWidth, height: adjustedCellHeight)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 6, bottom: 6, right: 20)
    }
}

extension AddProductViewController: UITextViewDelegate {
    func textViewDidBeginEditing (_ textView: UITextView) {
        let isPlaceholderText = { [self] in
            textView.text == namePlaceholder ||
            textView.text == costPlaceholder ||
            textView.text == descriptionPlaceholder ||
            textView.text == fullDescriptionPlaceholder
        }
        
        if  isPlaceholderText() {
            textView.text = nil
            textView.textColor = UIColor(named: "BlackText")
        }
        
        if isChangeVC {
            textView.textColor = UIColor(named: "BlackText")
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            textView.textColor = .lightGray
            
            switch textView {
            case nameTextView: textView.text = namePlaceholder
            case costTextView: textView.text = costPlaceholder
            case descriptionTextView: textView.text = descriptionPlaceholder
            case fullDescriptionTextView:  textView.text = fullDescriptionPlaceholder
            default: textView.text = "Описание"
            }
        } else {
            textView.textColor = UIColor(named: "BlackText")
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        let newSize = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        
        let minHeight: CGFloat = 40
        let newHeight = max(newSize.height, minHeight)
        
        textView.snp.updateConstraints { make in
            make.height.equalTo(newHeight)
        }
        
        view.layoutIfNeeded()
    }
    
    private func updateTextViewHeight(textView: UITextView, heightConstraint: NSLayoutConstraint) {
        let newSize = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        let maxHeight: CGFloat = 200
        let newHeight = min(newSize.height, maxHeight)
        
        if heightConstraint.constant != newHeight {
            heightConstraint.constant = newHeight
            view.layoutIfNeeded()
        }
    }

    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        isErrorTextField(textView: nameTextView, isError: false)
        isErrorTextField(textView: costTextView, isError: false)
        isErrorTextField(textView: descriptionTextView, isError: false)
        isErrorTextField(textView: fullDescriptionTextView, isError: false)
        setDefaultPhotoButtonStyle(isError: false)
        
        return true
    }
    
    func isErrorTextField(textView: UITextView, isError: Bool) {
        let isPlaceholderText = { [self] in
            textView.text == namePlaceholder ||
            textView.text == costPlaceholder ||
            textView.text == descriptionPlaceholder ||
            textView.text == fullDescriptionPlaceholder
        }
        
        textView.layer.borderWidth = isError ? 1 : 0
        textView.layer.borderColor = isError ? UIColor.red.cgColor : nil
        
        if isPlaceholderText() && isError {
            textView.textColor = .red
        } else if isPlaceholderText() {
            textView.textColor = .lightGray
        } else {
            textView.textColor = UIColor(named: "BlackText")
        }
    }
    
    func adjustUITextViewHeight(arg : UITextView) {
        arg.textColor = UIColor(named: "BlackText")
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
}
