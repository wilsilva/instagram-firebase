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
    func collectionView(datasource controller: UICollectionViewDataSource)
    func collectionView(delegate controller: UICollectionViewDelegate)
    func collectionView(insertImage image: UIImage)
    func updateHeaderImage(image: UIImage)
    func addHeaderTapGestureRecognizer(_ target: Any?,action: Selector?)
    func addHeaderPanGestureRecognizer(_ delegate: UIGestureRecognizerDelegate,target: Any?,action: Selector?)
    func pushHeaderUp(header: ImageSelectorHeader)
    func pullHeaderDown(header: ImageSelectorHeader)
}
