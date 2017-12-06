//
//  ImageSelectorNavigationControllerViewController.swift
//  Instagram
//
//  Created by tiago henrique on 04/12/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class ImageSelectorNavigationController: UINavigationController, ImageSelectorNavigationControllerProtocol {
    
    var scrollableNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.isTranslucent = false
        return navigationBar
    }()
    
    var scrollableNavigationBarTopAnchor: NSLayoutConstraint?
    
    func setScrollableNavigationBarVerticalPosition(_ y: CGFloat) {
        scrollableNavigationBarTopAnchor?.constant = y
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
        navigationBar.isHidden = true
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func setupViews(){
        view.addSubview(scrollableNavigationBar)
        scrollableNavigationBar.anchors(top: nil, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: navigationBar.frame.height)
        scrollableNavigationBarTopAnchor = scrollableNavigationBar.topAnchor.constraint(equalTo: view.topAnchor)
        scrollableNavigationBarTopAnchor?.isActive = true
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        if var rootViewController = rootViewController as? ImageSelectorViewControllerProtocol{
            rootViewController.imageSelectorNavigationController = self
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
}
