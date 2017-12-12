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
    var imageSelectorTopAnchor: NSLayoutConstraint?
    let imageSizeForCell = CGSize(width: 200, height: 200)
    let imageSizeForHeader = CGSize(width: 600, height: 600)
    let header = ImageSelectorHeader()
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    func collectionView(setScrollState enabled: Bool) {
        self.collectionView.isScrollEnabled = enabled
    }
    
    func getScrollDirection(by velocity: CGPoint) -> ScrollDirection {
        return velocity.y <= 0 ? .Up : .Down
    }
    
    func collectionView(insertImage image: UIImage, index: Int) {
        collectionView.insertItems(at: [IndexPath(item: index, section: 0)])
    }
    
    func getScrollState(view: UIView) -> ScrollState {
        if header.info.headerState == .opened{
            if view == self.header || view == self.header.selectedImage{
                return .disabled
            }
        }else{
            if self.collectionView.contentOffset.y > 0.0 || header.info.scrollDirection == .Up{
                return .disabled
            }
        }
        
        return .enabled
    }
    
    func setScrollDirection(by velocity: CGPoint) {
        self.header.info.scrollDirection = getScrollDirection(by: velocity)
    }
    
    func setScrollState(view: UIView) {
        self.header.info.scrollState = getScrollState(view: view)
    }
    
    func pushHeaderUp(header: ImageSelectorHeader) {
        self.header.info.headerState = .closed
        self.imageSelectorTopAnchor?.constant = -self.header.frame.maxY
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.header.blackForeground.alpha = 1
            self?.layoutIfNeeded()
        }, completion: nil)
    }
    
    func pullHeaderDown(header: ImageSelectorHeader) {
        header.info.headerState = .opened
        self.imageSelectorTopAnchor?.constant = 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.header.blackForeground.alpha = 0
            self?.layoutIfNeeded()
        }, completion: nil)
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
        collectionView.numberOfItems(inSection: 0)
    }
    
    func collectionView(delegate controller: UICollectionViewDelegate) {
        self.collectionView.delegate = controller
    }
    
    required init(controller: ImageSelectorControllerProtocol, frame: CGRect) {
        super.init(frame: frame)
        self.controller = controller
        self.backgroundColor = UIColor.white
        
        addSubview(header)
        addSubview(collectionView)
        
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
