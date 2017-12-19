//
//  ImageSelectorNavigationControllerViewController.swift
//  Instagram
//
//  Created by tiago henrique on 04/12/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class UISeparateNavigationController: UIViewController{
    
    let imageSelectionNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.view.translatesAutoresizingMaskIntoConstraints = false
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }()
    
    var navigationControllerTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func setupViews(){
        view.addSubview(imageSelectionNavigationController.view)
        imageSelectionNavigationController.view.anchors(top: nil, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        navigationControllerTopAnchor = imageSelectionNavigationController.view.topAnchor.constraint(equalTo: view.topAnchor)
        navigationControllerTopAnchor?.isActive = true
    }
    
    init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil) 
        if let rootViewController = rootViewController as? ImageSelectionController{
            rootViewController.separateNavigationControler = self
        }
        imageSelectionNavigationController.viewControllers = [rootViewController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
