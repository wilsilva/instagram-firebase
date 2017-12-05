//
//  ImageSelectorController.swift
//  Instagram
//
//  Created by tiago turibio on 13/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit
import Photos

class ImageSelectorController: UIViewController, ImageSelectorViewControllerProtocol,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate {
    
    var imageSelectorNavigationController: ImageSelectorNavigationController?    
    let imageSizeForCell = CGSize(width: 200, height: 200)
    let imageSizeForHeader = CGSize(width: 600, height: 600)
    var images = [(image: UIImage,asset: PHAsset)]()
    let navigationBarHeight: CGFloat = 50
    let header = ImageSelectorHeader()
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.numberOfItems(inSection: 0)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.backgroundColor = .white
        self.collectionView.register(ImageSelectorCell.self, forCellWithReuseIdentifier: ImageSelectorCell.ID)
        
        setupViews()
        setupNavigationItems(navigationBar: imageSelectorNavigationController!.scrollableNavigationBar)
        fetchUserPhotos(withImageSize: imageSizeForCell,completion: loadImages)
        setupEdgeGestureRecognizer(views: view)
        setupTapGestureRecognizer(views: header.scrollableFrame)
    }

    fileprivate func getFetchOptions() -> PHFetchOptions{
        let options = PHFetchOptions()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        options.sortDescriptors = [sortDescriptor]
        return options
    }
    
    fileprivate func fetchUserPhotos(withImageSize imageSize: CGSize, completion: @escaping (((UIImage,PHAsset)) -> Void)){
        let result = PHAsset.fetchAssets(with: .image, options: getFetchOptions())
        DispatchQueue.global(qos: .background).async {
            result.enumerateObjects { (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image{
                        completion((image,asset))
                    }
                })
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func setupEdgeGestureRecognizer(views: UIView...){
        for view in views {
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(edgeGestureRecognizer))
            panGestureRecognizer.delegate = self
            view.addGestureRecognizer(panGestureRecognizer)
        }
    }
    
    func setupTapGestureRecognizer(views: UIView...){
        for view in views {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer))
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func tapGestureRecognizer(){
        if header.info.headerState == .closed{
            pullHeaderDown(header: header, navigationBar: imageSelectorNavigationController!.scrollableNavigationBar)
        }
    }
    
    fileprivate func getScrollDirection(by velocity: CGPoint) -> ScrollDirection{
        return velocity.y <= 0 ? .Up : .Down
    }
    
    fileprivate func getScrollState(by headerState: HeaderState, view: UIView) -> ScrollState{
        if headerState == .opened{
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
    
    fileprivate func headerCanScrollUpFrom(_ currentLocation: CGPoint, header: UIView) -> Bool{
        return currentLocation.y <= (header.frame.maxY - ImageSelectorHeader.scrollableFrameHeight)
    }
    
    fileprivate func headerCanScrollDownFrom(_ currentLocation: CGPoint, header: UIView) -> Bool{
        return currentLocation.y <= header.frame.maxY && header.frame.maxY <= header.frame.height + ImageSelectorHeader.scrollableFrameHeight
    }
    
    fileprivate func collectionViewIsAtTheTop(_ currentLocation: CGPoint) -> Bool{
        return self.collectionView.contentOffset.y <= 0.0
    }
    
    @objc func edgeGestureRecognizer(_ panGestureRecognizer: UIPanGestureRecognizer){
        if let view = panGestureRecognizer.view{
            
            let currentLocation = panGestureRecognizer.location(in: view)
            let pannedView = view.hitTest(currentLocation, with: nil)
            let translation = panGestureRecognizer.translation(in: view)
            let velocity = panGestureRecognizer.velocity(in: view)
            
            header.info.scrollDirection = self.getScrollDirection(by: velocity)
            self.collectionView.isScrollEnabled = true
            
            if let pannedView = pannedView{
                switch(panGestureRecognizer.state){
                case .began:
                    header.info.scrollState = self.getScrollState(by: header.info.headerState, view: pannedView)
                case .changed:
                    if header.info.scrollState == .enabled{
                        if header.info.scrollDirection == .Up{
                            if header.info.headerState == .opened{
                                if headerCanScrollUpFrom(currentLocation, header: header){
                                    self.collectionView.isScrollEnabled = false
                                    imageSelectorNavigationController?.scrollableNavigationBarTopAnchor?.constant += translation.y
                                }
                            }else{
                                if collectionViewIsAtTheTop(self.collectionView.contentOffset) {
                                    self.collectionView.isScrollEnabled = false
                                    imageSelectorNavigationController?.scrollableNavigationBarTopAnchor?.constant += translation.y
                                }
                            }
                        }
                        else{
                            if header.info.headerState == .opened{
                                if headerCanScrollDownFrom(currentLocation, header: header){
                                    self.collectionView.isScrollEnabled = false
                                    imageSelectorNavigationController?.scrollableNavigationBarTopAnchor?.constant = min((imageSelectorNavigationController?.scrollableNavigationBarTopAnchor!.constant)! + translation.y,0.0)
                                }
                            }else{
                                if collectionViewIsAtTheTop(self.collectionView.contentOffset) {
                                    self.collectionView.isScrollEnabled = false
                                    imageSelectorNavigationController?.scrollableNavigationBarTopAnchor?.constant = min((imageSelectorNavigationController?.scrollableNavigationBarTopAnchor!.constant)! + translation.y,0.0)
                                }
                            }
                        }
                    }
                    
                case .ended:
                    if header.info.scrollState == .enabled{
                        if header.info.headerState == .opened && header.frame.maxY < header.scrollableFrame.frame.maxY{
                            pushHeaderUp(header: header, navigationBar: imageSelectorNavigationController!.scrollableNavigationBar)
                            return
                        }
                        
                        pullHeaderDown(header: header, navigationBar: imageSelectorNavigationController!.scrollableNavigationBar)
                    }
                default:
                    return
                }
            }
            panGestureRecognizer.setTranslation(CGPoint.zero, in: view.superview)
        }
    }
    
    fileprivate func pushHeaderUp(header: ImageSelectorHeader, navigationBar: UINavigationBar){
        header.info.headerState = .closed
        imageSelectorNavigationController!.scrollableNavigationBarTopAnchor?.constant = (ImageSelectorHeader.scrollableFrameHeight - navigationBarHeight) - header.frame.height
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.header.blackForeground.alpha = 1
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func pullHeaderDown(header: ImageSelectorHeader, navigationBar: UINavigationBar){
        header.info.headerState = .opened
        imageSelectorNavigationController!.scrollableNavigationBarTopAnchor?.constant = 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.header.blackForeground.alpha = 0
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setupViews(){
        view.addSubview(header)
        
        header.anchors(top: imageSelectorNavigationController!.scrollableNavigationBar.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: view.frame.width)
        
        collectionView.anchors(top: header.bottomAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    func loadImages(imageAsset: (image: UIImage,asset: PHAsset)){
        self.images.append(imageAsset)
        DispatchQueue.main.sync { [weak self] in
            if images.count == 1 {
                let asset = imageAsset.asset
                updateHeaderImage(asset, imageSize: imageSizeForHeader, header: header)
            }
            
            self?.collectionView.insertItems(at: [IndexPath(item: images.endIndex - 1, section: 0)])
        }
    }
    
    fileprivate func setupNavigationItems(navigationBar: UINavigationBar){
        let cancelButton = UINavigationItem()
        cancelButton.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        
        let nextButton = UINavigationItem()
        nextButton.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        navigationBar.setItems([cancelButton,nextButton], animated: false)
    }
    
    @objc func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext(){
        print("Next")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSelectorCell.ID, for: indexPath)
        if let imageSelectorCell = cell as? ImageSelectorCell{
            imageSelectorCell.photo = self.images[indexPath.row].image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width - 3) / 4
        return CGSize(width: size, height: size)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = self.images[indexPath.row].asset
        updateHeaderImage(asset, imageSize: imageSizeForHeader, header: header)
        pullHeaderDown(header: header, navigationBar: imageSelectorNavigationController!.scrollableNavigationBar)
    }
    
    func updateHeaderImage(_ asset: PHAsset, imageSize: CGSize, header: ImageSelectorHeader){
        let imageManager = PHImageManager.default()
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: nil) { (image, info) in
            header.selectedImage.image = image
        }
    }
}
