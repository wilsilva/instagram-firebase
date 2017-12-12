//
//  ImageSelectorViewProtocol.swift
//  Instagram
//
//  Created by tiago henrique on 11/12/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import Foundation
import UIKit
import Photos

protocol ImageSelectorControllerProtocol{
    var separateNavigationControler: UISeparateNavigationController? {set get}
}

protocol ImageSelectorViewProtocol{
    init(controller: ImageSelectorControllerProtocol, frame: CGRect)
    func collectionView(insertImage image: UIImage, index: Int)
    func collectionView(setScrollState enabled: Bool)
    func updateHeaderImage(image: UIImage)
    func addHeaderTapGestureRecognizer(_ target: Any?,action: Selector?)
    func addHeaderPanGestureRecognizer(_ delegate: UIGestureRecognizerDelegate,target: Any?,action: Selector?)
    func pushHeaderUp()
    func pullHeaderDown()
    func setScrollDirection(by velocity: CGPoint)
    func setScrollState(view: UIView)
    func scrollHeader(from currentLocation: CGPoint, translation: CGPoint)
    func attractHeader(using currentFrameLocation: CGFloat)
}
