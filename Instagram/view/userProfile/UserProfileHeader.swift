//
//  UserProfileHeader.swift
//  Instagram
//
//  Created by tiago turibio on 06/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    static let ID = "userProfileHeaderId"
    
    var user: User?{
        didSet{
            updateUI()
        }
    }
    
    var hideFollowButton: Bool = true
    
    let postsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    let followersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    let followsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    let userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    let listButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let postsInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let userProfileImageDimensions: CGSize = {
        return CGSize(width: 80, height: 80)
    }()
    
    let userProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let numberOfPosts: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("posts", comment: "")
        label.textColor = UIColor(white: 0, alpha: 0.3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfFollowers: UILabel = {
        let label = UILabel()
        label.text = "200"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("followers", comment: "")
        label.textColor = UIColor(white: 0, alpha: 0.3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfFollows: UILabel = {
        let label = UILabel()
        label.text = "300"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followsLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("follows", comment: "")
        label.textColor = UIColor(white: 0, alpha: 0.3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.black
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitle(NSLocalizedString("edit_profile", comment: ""), for: .normal)
        button.layer.cornerRadius = 3
        return button
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let ribbonButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerStackView)
        addSubview(listButtonsStackView)
        addSubview(postsInfoStackView)
        addSubview(userNameLabel)
        addSubview(editProfileButton)
        
        headerStackView.insertArrangedSubview(userProfileImage, at: 0)
        headerStackView.insertArrangedSubview(postsInfoStackView, at: 1)
        headerStackView.anchors(top: topAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 20, paddingRight: 0, paddingBottom: 0, paddingLeft: 20, width: 0, height: 0)
        
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
        
        userNameLabel.anchors(top: userProfileImage.bottomAnchor, right: nil, bottom: nil, left: nil, paddingTop: 15, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        userNameLabel.centerXAnchor.constraint(equalTo: userProfileImage.centerXAnchor).isActive = true
        
        editProfileButton.anchors(top: postsInfoStackView.bottomAnchor, right: postsInfoStackView.rightAnchor, bottom: nil, left: postsInfoStackView.leftAnchor, paddingTop: 10, paddingRight: -20, paddingBottom: 0, paddingLeft: 20, width: 0, height: 0)
    
        listButtonsStackView.anchors(top: nil, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: self.frame.width, height: 50)
        listButtonsStackView.insertArrangedSubview(gridButton, at: 0)
        listButtonsStackView.insertArrangedSubview(listButton, at: 1)
        listButtonsStackView.insertArrangedSubview(ribbonButton, at: 2)
        
        insertDivider(with: UIColor.lightGray, top: listButtonsStackView.topAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 1)
        insertDivider(with: UIColor.lightGray, top: listButtonsStackView.bottomAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func updateUI(){
        if let url = user?.profilePictureURL{
            if let cachedImage = userProfileCache[url.absoluteString]{
                userProfileImage.image = cachedImage
            }else{
                self.userProfileImage.loadImageWith(url: url, completion: { (data) in
                    DispatchQueue.main.async { [weak self] in
                        self?.userProfileImage.image = UIImage(data: data)
                    }
                })
            }
        }
        
        if let name = user?.name{
            userNameLabel.text = name
        }
        
        setupEditFollowButton()
        
    }
    
    func setupEditFollowButton(){
        if hideFollowButton{
            editProfileButton.setTitle(NSLocalizedString("edit_profile", comment: ""), for: .normal)
        }else{
            editProfileButton.setTitle(NSLocalizedString("follow", comment: ""), for: .normal)
        }
    }
}
