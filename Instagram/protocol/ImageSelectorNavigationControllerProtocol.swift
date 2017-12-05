//
//  ImageSelectorNavigationControllerProtocol.swift
//  Instagram
//
//  Created by tiago henrique on 04/12/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

protocol ImageSelectorNavigationControllerProtocol{
    var scrollableNavigationBar: UINavigationBar{get}
    var scrollableNavigationBarTopAnchor: NSLayoutConstraint?{get set}
    func setScrollableNavigationBarVerticalPosition(_ y: CGFloat)
}
