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
    
    let postsStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fill
        return sv
    }()
    
    let followersStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fill
        return sv
    }()
    
    let followsStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fill
        return sv
    }()
    
    let headerStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .top
        sv.axis = .horizontal
        sv.distribution = .fill
        return sv
    }()
    
    let userInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .fill
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 20
        return sv
    }()
    
    let listButtonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    let postsInfoStackView: UIStackView = {
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
        return lb
    }()
    
    let numberOfPosts: UILabel = {
        let lb = UILabel()
        lb.text = "100"
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let postsLabel: UILabel = {
        let lb = UILabel()
        lb.text = "posts"
        lb.textColor = UIColor(white: 0, alpha: 0.3)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let numberOfFollowers: UILabel = {
        let lb = UILabel()
        lb.text = "200"
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let followersLabel: UILabel = {
        let lb = UILabel()
        lb.text = "followers"
        lb.textColor = UIColor(white: 0, alpha: 0.3)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let numberOfFollows: UILabel = {
        let lb = UILabel()
        lb.text = "300"
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let followsLabel: UILabel = {
        let lb = UILabel()
        lb.text = "follows"
        lb.textColor = UIColor(white: 0, alpha: 0.3)
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
        
        addSubview(headerStackView)
        addSubview(listButtonsStackView)
        addSubview(postsInfoStackView)
        addSubview(userNameLabel)
        
        headerStackView.insertArrangedSubview(userProfileImage, at: 0)
        headerStackView.insertArrangedSubview(postsInfoStackView, at: 1)
        headerStackView.anchors(top: topAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 25, paddingRight: 0, paddingBottom: 0, paddingLeft: 25, width: 0, height: 150)
        
        postsInfoStackView.insertArrangedSubview(postsStackView, at: 0)
        postsInfoStackView.insertArrangedSubview(followersStackView, at: 1)
        postsInfoStackView.insertArrangedSubview(followsStackView, at: 2)
        
        postsStackView.insertArrangedSubview(numberOfPosts, at: 0)
        postsStackView.insertArrangedSubview(postsLabel, at: 1)
        
        followersStackView.insertArrangedSubview(numberOfFollowers, at: 0)
        followersStackView.insertArrangedSubview(followersLabel, at: 1)
        followsStackView.insertArrangedSubview(numberOfFollows, at: 0)
        followsStackView.insertArrangedSubview(followsLabel, at: 1)
        
        userProfileImage.anchors(top: headerStackView.topAnchor, right: nil, bottom: nil, left: headerStackView.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: userProfileImageDimensions.width, height: userProfileImageDimensions.height)
        userProfileImage.layer.cornerRadius = userProfileImageDimensions.height / 2
        
        userNameLabel.anchors(top: userProfileImage.bottomAnchor, right: nil, bottom: nil, left: nil, paddingTop: 20, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        userNameLabel.centerXAnchor.constraint(equalTo: userProfileImage.centerXAnchor).isActive = true
    
        listButtonsStackView.anchors(top: headerStackView.bottomAnchor, right: nil, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: self.frame.width, height: 50)
        listButtonsStackView.insertArrangedSubview(gridButton, at: 0)
        listButtonsStackView.insertArrangedSubview(listButton, at: 1)
        listButtonsStackView.insertArrangedSubview(ribbonButton, at: 2)
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
