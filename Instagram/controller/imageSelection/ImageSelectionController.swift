//
//  imageSelectorNavigationControler.swift
//  Instagram
//
//  Created by tiago turibio on 13/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit
import Photos

class ImageSelectionController: UIViewController,ImageSelectorControllerProtocol,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate {
    var imageSelectionView: ImageSelectorView?
    let imageSizeForCell = CGSize(width: 200, height: 200)
    let imageSizeForHeader = CGSize(width: 600, height: 600)
    let header = ImageSelectorHeader()
    
    var images = [(image: UIImage,asset: PHAsset)]()
    var separateNavigationControler: UISeparateNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSelectionView = ImageSelectorView(controller: self, frame: view.frame)
        self.view = imageSelectionView
        self.imageSelectionView?.collectionView(datasource: self)
        self.imageSelectionView?.collectionView(delegate: self)
        self.imageSelectionView?.imageSelectorTopAnchor = separateNavigationControler?.navigationControllerTopAnchor
        setupNavigationItems(navigationItem: self.navigationItem)
        fetchUserPhotos(withImageSize: imageSizeForCell,completion: loadImages)
        self.imageSelectionView?.addHeaderTapGestureRecognizer(self, action: #selector(tapGestureRecognizerHandler))
        self.imageSelectionView?.addHeaderPanGestureRecognizer(self, target: self, action: #selector(panGestureRecognizerHandler))
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
    
    @objc func tapGestureRecognizerHandler(){
        self.imageSelectionView?.pullHeaderDown(header: header)
    }
    
    fileprivate func scrollViewElementsWith(constant position: CGPoint){}
    
    fileprivate func headerCanScrollUpFrom(_ currentLocation: CGPoint, header: UIView) -> Bool{
        return currentLocation.y <= (header.frame.maxY - ImageSelectorHeader.scrollableFrameHeight)
    }
    
    fileprivate func headerCanScrollDownFrom(_ currentLocation: CGPoint, header: UIView) -> Bool{
        return currentLocation.y <= header.frame.maxY && header.frame.maxY <= header.frame.height + ImageSelectorHeader.scrollableFrameHeight
    }
    
    fileprivate func collectionViewIsAtTheTop(_ currentLocation: CGPoint) -> Bool{
//        return self.collectionView.contentOffset.y <= 0.0
        return false
    }
    
    @objc func panGestureRecognizerHandler(_ panGestureRecognizer: UIPanGestureRecognizer){
        if let view = panGestureRecognizer.view{
            let currentLocation = panGestureRecognizer.location(in: view)
            let pannedView = view.hitTest(currentLocation, with: nil)
            let translation = panGestureRecognizer.translation(in: view)
            let velocity = panGestureRecognizer.velocity(in: view)
            self.imageSelectionView?.setScrollDirection(by: velocity)
            self.imageSelectionView?.collectionView(setScrollState: true)
            if let pannedView = pannedView{
                switch(panGestureRecognizer.state){
                case .began:
                    self.imageSelectionView?.setScrollState(view: pannedView)
                case .changed:
                    if header.info.scrollState == .enabled{
                        if header.info.scrollDirection == .Up{
                            if header.info.headerState == .opened{
                                if headerCanScrollUpFrom(currentLocation, header: header){
                                    self.imageSelectionView?.collectionView(setScrollState: false)
                                    separateNavigationControler?.navigationControllerTopAnchor?.constant += translation.y
                                }
                            }else{
//                                if collectionViewIsAtTheTop(self.collectionView.contentOffset) {
//                                    self.imageSelectionView?.collectionView(setScrollState: false)
//                                    separateNavigationControler?.navigationControllerTopAnchor?.constant += translation.y
//                                }
                            }
                        }
                        else{
                            if header.info.headerState == .opened{
                                if headerCanScrollDownFrom(currentLocation, header: header){
                                    self.imageSelectionView?.collectionView(setScrollState: false)
                                    separateNavigationControler?.navigationControllerTopAnchor?.constant = min(separateNavigationControler!.navigationControllerTopAnchor!.constant + translation.y,0.0)
                                }
                            }else{
//                                if collectionViewIsAtTheTop(self.collectionView.contentOffset) {
//                                    self.imageSelectionView?.collectionView(setScrollState: false)
//                                    separateNavigationControler?.navigationControllerTopAnchor?.constant = min(separateNavigationControler!.navigationControllerTopAnchor!.constant + translation.y,0.0)
//                                }
                            }
                        }
                    }
                case .ended:
                    if header.info.scrollState == .enabled{
                        if header.info.headerState == .opened && header.scrollableFrame.frame.minY < (self.view.frame.maxY - header.frame.maxY){
                            self.imageSelectionView?.pushHeaderUp(header: header)
                            return
                        }
                        
                        self.imageSelectionView?.pullHeaderDown(header: header)
                    }
                default:
                    return
                }
            }
            panGestureRecognizer.setTranslation(CGPoint.zero, in: view.superview)
        }
    }
    
    func loadImages(imageAsset: (image: UIImage,asset: PHAsset)){
        self.images.append(imageAsset)
        DispatchQueue.main.sync { [weak self] in
            if images.count == 1 {
                let asset = imageAsset.asset
                updateHeaderImage(asset, imageSize: imageSizeForHeader)
            }
            self?.imageSelectionView?.collectionView(insertImage: imageAsset.image, index: self!.images.endIndex - 1)
        }
    }
    
    fileprivate func setupNavigationItems(navigationItem: UINavigationItem){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(handleNext))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func handleCancel(){
        self.separateNavigationControler?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext(){
        let imageCaptionController = ImageCaptionController()
        navigationController?.pushViewController(imageCaptionController, animated: true)
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
        updateHeaderImage(asset, imageSize: imageSizeForHeader)
        self.imageSelectionView?.pullHeaderDown(header: header)
    }
    
    func updateHeaderImage(_ asset: PHAsset, imageSize: CGSize){
        let imageManager = PHImageManager.default()
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: nil) { (image, info) in
            self.imageSelectionView?.updateHeaderImage(image: image!)
        }
    }
}
