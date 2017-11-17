//
//  ImageSelectorController.swift
//  Instagram
//
//  Created by tiago turibio on 13/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit
import Photos

class ImageSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let imageSize = CGSize(width: 350, height: 350)
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(ImageSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ImageSelectorHeader.ID)
        self.collectionView?.register(UserPhotoCell.self, forCellWithReuseIdentifier: UserPhotoCell.ID)
        self.navigationController?.navigationBar.tintColor = .black
        setupNavigationItems()
        fetchUserPhotos(withImageSize: imageSize,completion: loadImages)
    }
    
    func fetchUserPhotos(withImageSize imageSize: CGSize, completion: (([UIImage]) -> Void)?){
        var images = [UIImage]()
        let result = PHAsset.fetchAssets(with: .image, options: PHFetchOptions())
        result.enumerateObjects { (asset, count, stop) in
            let imageManager = PHImageManager.default()
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                if let image = image{
                    images.append(image)
                }
                
                if count == result.count - 1{
                    if let completion = completion{
                        completion(images)
                    }
                }
            })
        }
    }
    
    func loadImages(images: [UIImage]){
        self.images = images
        self.collectionView?.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = view.frame.width
        return CGSize(width: size, height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ImageSelectorHeader.ID, for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserPhotoCell.ID, for: indexPath)
        if let userPhotoCell = cell as? UserPhotoCell{
            userPhotoCell.photo = self.images[indexPath.row]
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
        print(self.images.count)
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPathForHeader = IndexPath(row: 0, section: indexPath.section)
        let header = collectionView.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: indexPathForHeader)
        let cell = collectionView.cellForItem(at: indexPath)
        
        if let userPhotoCell = cell as? UserPhotoCell, let imageSelectorHeader = header as? ImageSelectorHeader{
            imageSelectorHeader.selectedPhoto = userPhotoCell.photo
        }
    }
}
