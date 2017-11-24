//
//  ImageSelectorNavigationBarItem.swift
//  Instagram
//
//  Created by tiago henrique on 24/11/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class ImageSelectorNavigationBarItem: UIButton {
    required init(title: String?, controlState: UIControlState, target: Any?, action: Selector?) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.black, for: controlState)
        
        if let  title = title{
            setTitle(title, for: controlState)
        }
        
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
