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
    let navigationBarHeight: CGFloat = 60
    
    let header: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let scrollableHeaderPiece: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let navigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView?.register(UserPhotoCell.self, forCellWithReuseIdentifier: UserPhotoCell.ID)
        self.navigationController?.navigationBar.tintColor = .black
        setupViews()
        setupNavigationItems()
        fetchUserPhotos()
        setupEdgeGesture(views: self.view)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func setupEdgeGesture(views: UIView...){
        for view in views {
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(edgeGestureRecognizer))
            panGestureRecognizer.delegate = self
            view.addGestureRecognizer(panGestureRecognizer)
        }
    }
    
    @objc func edgeGestureRecognizer(_ panGestureRecognizer: UIPanGestureRecognizer){
        if let view = panGestureRecognizer.view{
            let currentLocation = panGestureRecognizer.location(in: view)
            let pinnedView = view.hitTest(currentLocation, with: nil)
            let translation = panGestureRecognizer.translation(in: view)
            let velocity = panGestureRecognizer.velocity(in: view)
            scrollDirection = velocity.y <= 0 ? .Up : .Down
            
            if let pinnedView = pinnedView{
                switch(panGestureRecognizer.state){
                case .began:
                    
                    if pinnedView == self.header{
                        scrollState = .disabled
                        return
                    }
                    
                    scrollState = .enabled
                    
                case .changed:
                    if scrollState == .enabled{
                        if scrollDirection == .Up{
                            if currentLocation.y <= (header.frame.maxY - scrollableHeaderPieceHeight){
                                headerTopAnchor?.constant += translation.y
                            }
                        }
                        else{
                            if headerState == .opened{
                                if currentLocation.y <= header.frame.maxY && header.frame.maxY <= header.frame.height{
                                    headerTopAnchor?.constant = min(headerTopAnchor!.constant + translation.y,0.0)
                                }
                            }else{
                                if (currentLocation.y <= header.frame.maxY && header.frame.maxY <= header.frame.height) || self.collectionView!.contentOffset.y <= 0.0 {
                                    headerTopAnchor?.constant = min(headerTopAnchor!.constant + translation.y,0.0)
                                }
                            }
                        }
                    }
                    
                case .ended:
                    let headerYcenter = header.frame.height / 2
                    let currentHeaderPosition = header.frame.maxY - (scrollableHeaderPieceHeight + navigationBarHeight)
                    
                    if currentHeaderPosition < headerYcenter{
                        headerState = .closed
                        pushHeaderUp()
                    }else{
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
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func pullHeaderDown(){
        headerTopAnchor?.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setupViews(){
        view.addSubview(header)
        view.addSubview(navigationBar)
        header.addSubview(scrollableHeaderPiece)
        
        navigationBar.anchors(top: nil, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: navigationBarHeight)
        
        header.anchors(top: navigationBar.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: view.frame.width)
        
        headerTopAnchor = navigationBar.topAnchor.constraint(equalTo: view.topAnchor)
        headerTopAnchor!.isActive = true
        
        scrollableHeaderPiece.anchors(top: nil, right: header.rightAnchor, bottom: header.bottomAnchor, left: header.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: scrollableHeaderPieceHeight)
        
        collectionView?.anchors(top: header.bottomAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    func fetchUserPhotos(){
    }
    
    func setupNavigationItems(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(handleNext))
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
