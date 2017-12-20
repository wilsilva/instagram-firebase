//
//  PostCell.swift
//  Instagram
//
//  Created by tiago turibio on 19/12/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import Foundation
import UIKit

class PostCell: UICollectionViewCell{
    static var ID = "postCell"
    var post: Post?{
        didSet{
            
        }
    }
    
    let headerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let footerContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .gray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let userProfileImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "plus_photo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NightLife"
        return label
    }()
    
    let moreOptions: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let likePost: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        return button
    }()
    
    let commentPost: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        return button
    }()
    
    let sharePost: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        return button
    }()
    
    let savePost: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        return button
    }()
    
    let postCaption: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews(){
        addSubview(headerContainer)
        addSubview(postImage)
        addSubview(footerContainer)
        addSubview(savePost)
        
        headerContainer.addSubview(userProfileImage)
        headerContainer.addSubview(userName)
        headerContainer.addSubview(moreOptions)
        headerContainer.anchors(top: topAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 56)
        
        userProfileImage.anchors(top: topAnchor, right: nil, bottom: nil, left: leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 40, height: 40)
        
        userName.anchors(top: topAnchor, right: nil, bottom: nil, left: userProfileImage.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        userName.centerYAnchor.constraint(equalTo: userProfileImage.centerYAnchor, constant: 0).isActive = true
        
        moreOptions.anchors(top: topAnchor, right: rightAnchor, bottom: nil, left: nil, paddingTop: 0, paddingRight: -8, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        moreOptions.centerYAnchor.constraint(equalTo: userProfileImage.centerYAnchor, constant: 0).isActive = true
        
        postImage.anchors(top: headerContainer.bottomAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 100)
        
        footerContainer.anchors(top: postImage.bottomAnchor, right: nil, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 120, height: 56)
        footerContainer.insertArrangedSubview(likePost, at: 0)
        footerContainer.insertArrangedSubview(commentPost, at: 1)
        footerContainer.insertArrangedSubview(sharePost, at: 2)
        
        savePost.anchors(top: postImage.bottomAnchor, right: rightAnchor, bottom: nil, left: nil, paddingTop: 0, paddingRight: -8, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        savePost.centerYAnchor.constraint(equalTo: footerContainer.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
