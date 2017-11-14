//
//  ImageSelectorHeader.swift
//  Instagram
//
//  Created by tiago henrique on 14/11/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class ImageSelectorHeader: UICollectionViewCell {
    static var ID = "imageSelectorHeaderId"
    
    var selectedPhoto: UIImage?{
        didSet{
            updateUI()
        }
    }
    
    let userImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func updateUI(){
        userImage.image = selectedPhoto
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(userImage)
        userImage.anchors(top: topAnchor, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
