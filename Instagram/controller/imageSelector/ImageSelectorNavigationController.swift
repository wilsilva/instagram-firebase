//
//  ImageSelectorNavigationControllerViewController.swift
//  Instagram
//
//  Created by tiago henrique on 04/12/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class ImageSelectorNavigationController: UIViewController {
    
    var scrollableNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.isTranslucent = false
        return navigationBar
    }()
    
    let imageSelectorNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        navigationController.view.translatesAutoresizingMaskIntoConstraints = false
        return navigationController
    }()
    
    var scrollableNavigationBarTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func setupViews(){
        view.addSubview(scrollableNavigationBar)
        view.addSubview(imageSelectorNavigationController.view)
        let imageSelector = ImageSelectorController()
        imageSelector.imageSelectorNavigationController = self
        imageSelectorNavigationController.viewControllers = [imageSelector]
        
        scrollableNavigationBar.anchors(top: nil, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: imageSelectorNavigationController.navigationBar.frame.height)
        scrollableNavigationBarTopAnchor = scrollableNavigationBar.topAnchor.constraint(equalTo: view.topAnchor)
        scrollableNavigationBarTopAnchor?.isActive = true
        
        imageSelectorNavigationController.view.anchors(top: scrollableNavigationBar.bottomAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
}
