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
    var scrollableNavigationBarTopPosition: NSLayoutConstraint{get set}
    func setScrollableNavigationBarPosition(_ position: CGPoint)
}
