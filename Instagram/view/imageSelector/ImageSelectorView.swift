//
//  ImageSelectorView.swift
//  Instagram
//
//  Created by tiago henrique on 11/12/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import Foundation
import UIKit
import Photos

class ImageSelectorView: UIView, ImageSelectorViewProtocol{
    
    var controller: ImageSelectorControllerProtocol?
    
    let imageSizeForCell = CGSize(width: 200, height: 200)
    let imageSizeForHeader = CGSize(width: 600, height: 600)
    let header = ImageSelectorHeader()
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    func pushHeaderUp(header: ImageSelectorHeader) {
        
    }
    
    func pullHeaderDown(header: ImageSelectorHeader) {
        
    }
    
    func addHeaderTapGestureRecognizer(_ target: Any?, action: Selector?) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        header.scrollableFrame.addGestureRecognizer(tapGesture)
    }
    
    func addHeaderPanGestureRecognizer(_ delegate: UIGestureRecognizerDelegate, target: Any?, action: Selector?) {
        let panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        panGestureRecognizer.delegate = delegate
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    func updateHeaderImage(image: UIImage) {
        header.selectedImage.image = image
    }
    
    func collectionView(datasource controller: UICollectionViewDataSource) {
        self.collectionView.dataSource = controller
    }
    
    func collectionView(delegate controller: UICollectionViewDelegate) {
        self.collectionView.delegate = controller
    }
    
    func collectionView(insertImage image: UIImage) {
        let endIndex = self.collectionView.numberOfItems(inSection: 0)
        self.collectionView.insertItems(at: [IndexPath(item: endIndex, section: 0)])
    }
    
    required init(controller: ImageSelectorControllerProtocol, frame: CGRect) {
        super.init(frame: frame)
        self.controller = controller
        self.backgroundColor = UIColor.white
        
        addSubview(header)
        addSubview(collectionView)
        
        collectionView.numberOfItems(inSection: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(ImageSelectorCell.self, forCellWithReuseIdentifier: ImageSelectorCell.ID)
        header.anchors(top: topAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: frame.width)
        collectionView.anchors(top: header.bottomAnchor, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
