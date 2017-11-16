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
    
    let selectedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let imageActions: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        self.view.backgroundColor = .white
        //        self.collectionView?.register(ImageSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ImageSelectorHeader.ID)
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView?.register(UserPhotoCell.self, forCellWithReuseIdentifier: UserPhotoCell.ID)
        self.navigationController?.navigationBar.tintColor = .black
        setupViews()
        setupNavigationItems()
        fetchUserPhotos()
        setupEdgeGesture(views: view)
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
        let targetView = panGestureRecognizer.view!
//        let translation = panGestureRecognizer.translation(in: targetView)
        let currentLocation = panGestureRecognizer.location(in: targetView)
        let currentView = targetView.hitTest(currentLocation, with: nil)
        
        switch panGestureRecognizer.state {
        case .began,.changed:
            if let currentView = currentView{
                switch currentView{
                case imageActions:
                    print("actions")
                case collectionView!:
                    print("collection")
                case view:
                    print("view")
                default:
                    return
                }
            }
        case .ended:
            return
        default:
            return
        }
    }
    
    func setupViews(){
        view.addSubview(selectedImage)
        view.addSubview(divider)
        selectedImage.addSubview(imageActions)
        selectedImage.anchors(top: view.topAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: view.frame.width)
        divider.anchors(top: selectedImage.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 2)
        imageActions.anchors(top: nil, right: selectedImage.rightAnchor, bottom: selectedImage.bottomAnchor, left: selectedImage.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: view.frame.width / 6)
        
        collectionView?.anchors(top: selectedImage.bottomAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 1, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
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
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //        return CGSize(width: view.frame.width, height: 200)
    //    }
    
    //    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ImageSelectorHeader.ID, for: indexPath)
    //        return cell
    //    }
    
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
