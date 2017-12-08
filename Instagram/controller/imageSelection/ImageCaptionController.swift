//
//  ImageCaptionController.swift
//  Instagram
//
//  Created by tiago turibio on 07/12/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class ImageCaptionController: UIViewController {
    
    let captionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    let selectedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let captionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .green
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupNavigationItems(navigationItem: self.navigationItem)
    }
    
    fileprivate func setupViews(){
        self.view.addSubview(captionStackView)
        captionStackView.addSubview(selectedImage)
        captionStackView.addSubview(captionTextField)
        
        captionStackView.anchors(top: view.topAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        
        selectedImage.anchors(top: nil, right: nil, bottom: nil, left: captionStackView.leftAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 8, paddingLeft: 0, width: 100, height: 100)
        
        captionTextField.anchors(top: captionStackView.topAnchor, right: captionStackView.rightAnchor, bottom: captionStackView.bottomAnchor, left: selectedImage.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    fileprivate func setupNavigationItems(navigationItem: UINavigationItem){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: nil)
    }
}
