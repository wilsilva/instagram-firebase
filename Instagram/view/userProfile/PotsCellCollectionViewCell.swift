//
//  PotsCellCollectionViewCell.swift
//  Instagram
//
//  Created by tiago henrique on 14/12/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class PotsCellCollectionViewCell: UICollectionViewCell {
    static let ID = "postCellID"
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        addSubview(imageView)
        imageView.anchors(top: topAnchor, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
