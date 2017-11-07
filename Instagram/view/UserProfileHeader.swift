//
//  UserProfileHeader.swift
//  Instagram
//
//  Created by tiago turibio on 06/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    static var ID = "headerId"
    var user: User?{
        didSet{
            updateUI()
        }
    }
    
    let userProfileImageDimensions: CGSize = {
        return CGSize(width: 80, height: 80)
    }()
    
    let userProfileImage: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        addSubview(userProfileImage)
        userProfileImage.anchors(top: topAnchor, right: nil, bottom: nil, left: leftAnchor, paddingTop: 12, paddingRight: 0, paddingBottom: 0, paddingLeft: 12, width: userProfileImageDimensions.width, height: userProfileImageDimensions.height)
        userProfileImage.layer.cornerRadius = userProfileImageDimensions.height / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func updateUI(){
        if let url = user?.profilePictureURL{
            do{
                let data = try Data(contentsOf: url)
                userProfileImage.image = UIImage(data: data)
            }catch{}
        }
    }
}
