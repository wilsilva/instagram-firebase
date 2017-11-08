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
//            updateUI()
        }
    }
    
    let listButtonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    let userProfileImageDimensions: CGSize = {
        return CGSize(width: 80, height: 80)
    }()
    
    let userProfileImage: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.backgroundColor = UIColor.black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let userNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "tiago henrique"
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    
    let numberOfPosts: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let postsLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let numberOfFollowers: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let followersLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let numberOfFollows: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let followsLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let editProfileButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    
    let gridButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return bt
    }()
    
    let listButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        bt.tintColor = UIColor(white: 0, alpha: 0.2)
        return bt
    }()
    
    let ribbonButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.tintColor = UIColor(white: 0, alpha: 0.2)
        bt.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userProfileImage)
        addSubview(userNameLabel)
        addSubview(listButtonsStackView)
        
        userProfileImage.anchors(top: topAnchor, right: nil, bottom: nil, left: leftAnchor, paddingTop: 12, paddingRight: 0, paddingBottom: 0, paddingLeft: 12, width: userProfileImageDimensions.width, height: userProfileImageDimensions.height)
        
        userProfileImage.layer.cornerRadius = userProfileImageDimensions.height / 2
        
        listButtonsStackView.anchors(top: userNameLabel.bottomAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: self.frame.width, height: 50)
        
        listButtonsStackView.insertArrangedSubview(gridButton, at: 0)
        listButtonsStackView.insertArrangedSubview(listButton, at: 1)
        listButtonsStackView.insertArrangedSubview(ribbonButton, at: 2)
        
        userNameLabel.anchors(top: userProfileImage.bottomAnchor, right: nil, bottom: nil, left: leftAnchor, paddingTop: 12, paddingRight: 0, paddingBottom: 0, paddingLeft: 12, width: 300, height: 30)
        
        userNameLabel.centerXAnchor.constraint(equalTo: userProfileImage.centerXAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func updateUI(){
        if let url = user?.profilePictureURL{
            do{
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    self?.userProfileImage.image = UIImage(data: data)
                }
            }catch{}
        }
        
        if let name = user?.name{
            userNameLabel.text = name
        }
    }
}
