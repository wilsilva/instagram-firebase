//
//  ImageSelectorNavigationBar.swift
//  Instagram
//
//  Created by tiago henrique on 22/11/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class ImageSelectorNavigationBar: UIView, ImageSelectorNavigationBarProtocol {
    
    var leftBarButtonItem: UIBarButtonItem?{
        didSet{
            print("left button set")
        }
    }
    
    var rightBarButtonItem: UIBarButtonItem?{
        didSet{
            print("right button set")
        }
    }
    
    let navigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    fileprivate func setupViews(){
        self.addSubview(navigationBar)
        navigationBar.anchors(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
