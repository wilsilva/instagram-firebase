//
//  ImageCaptionController.swift
//  Instagram
//
//  Created by tiago turibio on 07/12/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class ImageCaptionController: UIViewController {
    
    var selectedImage = UIImage(){
        didSet{
            selectedImageView.image = selectedImage
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let captionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        setupViews()
        setupNavigationItems(navigationItem: self.navigationItem)
    }
    
    fileprivate func setupViews(){
        self.view.addSubview(containerView)
        containerView.addSubview(selectedImageView)
        containerView.addSubview(captionTextView)
        
        containerView.anchors(top: view.topAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 100)
        
        selectedImageView.anchors(top: containerView.topAnchor, right: nil, bottom: nil, left: containerView.leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 84, height: 84)
        
        captionTextView.anchors(top: containerView.topAnchor, right: containerView.rightAnchor, bottom: containerView.bottomAnchor, left: selectedImageView.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
    }
    
    fileprivate func setupNavigationItems(navigationItem: UINavigationItem){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: nil)
    }
}
