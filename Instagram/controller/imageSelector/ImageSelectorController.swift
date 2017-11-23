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
    
    enum ScrollDirection {
        case Up
        case Down
    }
    
    enum ScrollState {
        case enabled
        case disabled
    }
    
    enum HeaderState {
        case opened
        case closed
    }
    
    var scrollDirection: ScrollDirection = .Up
    var scrollState: ScrollState = .enabled
    var headerState: HeaderState = .opened
    
    var headerTopAnchor: NSLayoutConstraint?
    let scrollableHeaderPieceHeight: CGFloat = 44
    let navigationBarHeight: CGFloat = 50
    var navigationBar = ImageSelectorNavigationBar()
    
    let header: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let headerBlackForeground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        return view
    }()
    
    let scrollableHeaderPiece: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView?.register(UserPhotoCell.self, forCellWithReuseIdentifier: UserPhotoCell.ID)
        setupViews()
        setupNavigationItems()
        fetchUserPhotos()
        setupEdgeGestureRecognizer(views: view)
        setupTapGestureRecognizer(views: scrollableHeaderPiece)
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
            headerState = .opened
        }
    }
    
    @objc func edgeGestureRecognizer(_ panGestureRecognizer: UIPanGestureRecognizer){
        if let view = panGestureRecognizer.view{
            
            let currentLocation = panGestureRecognizer.location(in: view)
            let pinnedView = view.hitTest(currentLocation, with: nil)
            let translation = panGestureRecognizer.translation(in: view)
            let velocity = panGestureRecognizer.velocity(in: view)
            scrollDirection = velocity.y <= 0 ? .Up : .Down
            
            self.collectionView?.isScrollEnabled = true
            
            if let pinnedView = pinnedView{
                switch(panGestureRecognizer.state){
                case .began:
                    if headerState == .opened{
                        if pinnedView == self.header || pinnedView == self.headerBlackForeground{
                            scrollState = .disabled
                            return
                        }
                        scrollState = .enabled
                    }else{
                        if self.collectionView!.contentOffset.y > 0.0 || scrollDirection == .Up{
                            scrollState = .disabled
                            return
                        }
                        scrollState = .enabled
                    }
                case .changed:
                    if scrollState == .enabled{
                        if scrollDirection == .Up{
                            if headerState == .opened{
                                if currentLocation.y <= (header.frame.maxY - scrollableHeaderPieceHeight){
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
                                if currentLocation.y <= header.frame.maxY && header.frame.maxY <= header.frame.height + scrollableHeaderPieceHeight{
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
                        if headerState == .opened && header.frame.maxY < scrollableHeaderPiece.frame.maxY{
                            headerState = .closed
                            pushHeaderUp()
                            return
                        }
                        
                        pullHeaderDown()
                        headerState = .opened
                    }
                default:
                    return
                }
            }
            panGestureRecognizer.setTranslation(CGPoint.zero, in: view.superview)
        }
    }
    
    fileprivate func pushHeaderUp(){
        headerTopAnchor?.constant = (scrollableHeaderPieceHeight - navigationBarHeight) - header.frame.height
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.headerBlackForeground.alpha = 1
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func pullHeaderDown(){
        headerTopAnchor?.constant = 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.headerBlackForeground.alpha = 0
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setupViews(){
        view.addSubview(header)
        view.addSubview(navigationBar)
        header.addSubview(headerBlackForeground)
        header.addSubview(scrollableHeaderPiece)
        
        navigationBar.anchors(top: nil, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: navigationBarHeight)
        
        header.anchors(top: navigationBar.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: view.frame.width)
        headerBlackForeground.anchors(top: header.topAnchor, right: header.rightAnchor, bottom: header.bottomAnchor, left: header.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        headerTopAnchor = navigationBar.topAnchor.constraint(equalTo: view.topAnchor)
        headerTopAnchor!.isActive = true
        
        scrollableHeaderPiece.anchors(top: nil, right: header.rightAnchor, bottom: header.bottomAnchor, left: header.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: scrollableHeaderPieceHeight)
        
        collectionView?.anchors(top: header.bottomAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    func fetchUserPhotos(){
    }
    
    func setupNavigationItems(){
        self.navigationBar.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        self.navigationBar.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(handleNext))
    }
    
    @objc func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext(){
        print("Next")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserPhotoCell.ID, for: indexPath)
        cell.backgroundColor = .yellow
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
        return 40
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let indexPathForHeader = IndexPath(row: 0, section: indexPath.section)
        //        let header = collectionView.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: indexPathForHeader)
        //        let cell = collectionView.cellForItem(at: indexPath)
        //
        //        if let userPhotoCell = cell as? UserPhotoCell, let imageSelectorHeader = header as? ImageSelectorHeader{
        //            imageSelectorHeader.selectedPhoto = userPhotoCell.photo
        //        }
    }
}
