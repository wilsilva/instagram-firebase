//
//  ImageSelectorController.swift
//  Instagram
//
//  Created by tiago turibio on 13/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit
import Photos

class ImageSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate {

    let imageSize = CGSize(width: 600, height: 600)
    var images = [UIImage]()
    
    var scrollDirection: ScrollDirection = .Up
    var scrollState: ScrollState = .enabled
    var headerState: HeaderState = .opened
    
    var headerTopAnchor: NSLayoutConstraint?
    let navigationBarHeight: CGFloat = 50
    var navigationBar = ImageSelectorNavigationBar()
    let header = ImageSelectorHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(ImageSelectorCell.self, forCellWithReuseIdentifier: ImageSelectorCell.ID)
        setupViews()
        setupNavigationItems(navigationBar: navigationBar)
        fetchUserPhotos(withImageSize: imageSize,completion: loadImages)
        setupEdgeGestureRecognizer(views: view)
        setupTapGestureRecognizer(views: header.scrollableFrame)
    }

    fileprivate func getFetchOptions() -> PHFetchOptions{
        let options = PHFetchOptions()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        options.sortDescriptors = [sortDescriptor]
        return options
    }
    
    fileprivate func fetchUserPhotos(withImageSize imageSize: CGSize, completion: @escaping ((UIImage) -> Void)){
        let result = PHAsset.fetchAssets(with: .image, options: getFetchOptions())
        DispatchQueue.global(qos: .background).async {
            result.enumerateObjects { (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image{
                        completion(image)
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
        if headerState == .closed{
            pullHeaderDown()
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
            if self.collectionView!.contentOffset.y > 0.0 || scrollDirection == .Up{
                return .disabled
            }
        }
        
        return .enabled
    }
    
    fileprivate func currentLocationIsShorterThenHeader(_ currentLocation: CGPoint, header: UIView) -> Bool{
        return currentLocation.y <= (header.frame.maxY - ImageSelectorHeader.scrollablFrameHeight)
    }
    
    @objc func edgeGestureRecognizer(_ panGestureRecognizer: UIPanGestureRecognizer){
        if let view = panGestureRecognizer.view{
            
            let currentLocation = panGestureRecognizer.location(in: view)
            let pannedView = view.hitTest(currentLocation, with: nil)
            let translation = panGestureRecognizer.translation(in: view)
            let velocity = panGestureRecognizer.velocity(in: view)
            scrollDirection = self.getScrollDirection(by: velocity)
            
            self.collectionView?.isScrollEnabled = true
            
            if let pannedView = pannedView{
                switch(panGestureRecognizer.state){
                case .began:
                    scrollState = self.getScrollState(by: headerState, view: pannedView)
                case .changed:
                    if scrollState == .enabled{
                        if scrollDirection == .Up{
                            if headerState == .opened{
                                if currentLocationIsShorterThenHeader(currentLocation, header: header){
                                    self.collectionView?.isScrollEnabled = false
                                    headerTopAnchor?.constant += translation.y
                                }
                            }else{
                                if self.collectionView!.contentOffset.y <= 0.0 {
                                    self.collectionView?.isScrollEnabled = false
                                    headerTopAnchor?.constant += translation.y
                                }
                            }
                        }
                        else{
                            if headerState == .opened{
                                if currentLocation.y <= header.frame.maxY && header.frame.maxY <= header.frame.height + ImageSelectorHeader.scrollablFrameHeight{
                                    self.collectionView?.isScrollEnabled = false
                                    headerTopAnchor?.constant = min(headerTopAnchor!.constant + translation.y,0.0)
                                }
                            }else{
                                if self.collectionView!.contentOffset.y <= 0.0 {
                                    self.collectionView?.isScrollEnabled = false
                                    headerTopAnchor?.constant = min(headerTopAnchor!.constant + translation.y,0.0)
                                }
                            }
                        }
                    }
                    
                case .ended:
                    if scrollState == .enabled{
                        if headerState == .opened && header.frame.maxY < header.scrollableFrame.frame.maxY{
                            pushHeaderUp()
                            return
                        }
                        
                        pullHeaderDown()
                    }
                default:
                    return
                }
            }
            panGestureRecognizer.setTranslation(CGPoint.zero, in: view.superview)
        }
    }
    
    fileprivate func pushHeaderUp(){
        headerState = .closed
        headerTopAnchor?.constant = (ImageSelectorHeader.scrollablFrameHeight - navigationBarHeight) - header.frame.height
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.header.blackForeground.alpha = 1
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func pullHeaderDown(){
        headerState = .opened
        headerTopAnchor?.constant = 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.header.blackForeground.alpha = 0
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setupViews(){
        view.addSubview(header)
        view.addSubview(navigationBar)
        
        navigationBar.anchors(top: nil, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: navigationBarHeight)
        header.anchors(top: navigationBar.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: view.frame.width)
        headerTopAnchor = navigationBar.topAnchor.constraint(equalTo: view.topAnchor)
        headerTopAnchor!.isActive = true
        collectionView?.anchors(top: header.bottomAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    func loadImages(image: UIImage){
        self.images.append(image)
        DispatchQueue.main.sync { [weak self] in
            if images.count == 1 {
                header.selectedImage.image = image
            }
            self?.collectionView?.insertItems(at: [IndexPath(item: images.endIndex - 1, section: 0)])
        }
    }
    
    fileprivate func setupNavigationItems(navigationBar: ImageSelectorNavigationBar){
        navigationBar.leftBarButtonItem = ImageSelectorNavigationBarItem(title: "Cancel", controlState: .normal, target: self, action: #selector(handleCancel))
        navigationBar.rightBarButtonItem = ImageSelectorNavigationBarItem(title: "Next", controlState: .normal, target: self, action: #selector(handleNext))
    }
    
    @objc func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext(){
        print("Next")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSelectorCell.ID, for: indexPath)
        if let imageSelectorCell = cell as? ImageSelectorCell{
            imageSelectorCell.photo = self.images[indexPath.row]
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if let imageSelectorCell = cell as? ImageSelectorCell, let photo = imageSelectorCell.photo{
            header.selectedImage.image = photo
            pullHeaderDown()
        }
    }
}
