//
//  UserSearchCellCollectionViewCell.swift
//  Instagram
//
//  Created by tiago henrique on 05/03/2018.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import UIKit

class UserSearchCellCollectionViewCell: UICollectionViewCell {
    
    static let ID = "UserSearchCellCollectionViewCell"
    
    let userProfilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "grid")
        return imageView
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "tiago"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let numberOfPosts: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "100 Posts"
        return label
    }()
    
    fileprivate func setupViews(){
        addSubview(userProfilePicture)
        addSubview(userName)
        addSubview(numberOfPosts)
        
        userProfilePicture.anchors(top: topAnchor, right: nil, bottom: nil, left: leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 60, height: 60)
        userName.anchors(top: userProfilePicture.topAnchor, right: nil, bottom: nil, left: userProfilePicture.rightAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        numberOfPosts.anchors(top: userName.bottomAnchor, right: nil, bottom: nil, left: userProfilePicture.rightAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        
        insertDivider(with: .lightGray, top: userProfilePicture.bottomAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
