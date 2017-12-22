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
    var imageCache = [String:UIImage?]()
    var post: Post?{
        didSet{
            loadPost()
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
    
    let commentsContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .gray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    let userProfileImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "plus_photo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NightLife"
        return label
    }()
    
    let moreOptions: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likePost: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let postComment: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let sharePost: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let savePost: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "ribbon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let postCaption: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.s"
        label.numberOfLines = 0
        return label
    }()
    
    let postDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5h ago"
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
        addSubview(commentsContainer)
        
        headerContainer.addSubview(userProfileImage)
        headerContainer.addSubview(userName)
        headerContainer.addSubview(moreOptions)
        headerContainer.anchors(top: topAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: -16, paddingBottom: 0, paddingLeft: 8, width: 0, height: 60)
        
        userProfileImage.anchors(top: nil, right: nil, bottom: nil, left: headerContainer.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 35, height: 35)
        userName.anchors(top: nil, right: moreOptions.leftAnchor, bottom: nil, left: userProfileImage.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        moreOptions.anchors(top: headerContainer.topAnchor, right: headerContainer.rightAnchor, bottom: nil, left: nil, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 44, height: 0)
        userName.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor, constant: 0).isActive = true
        userProfileImage.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor, constant: 0).isActive = true
        moreOptions.centerYAnchor.constraint(equalTo: userProfileImage.centerYAnchor, constant: 0).isActive = true
        
        postImage.anchors(top: headerContainer.bottomAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        postImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        footerContainer.anchors(top: postImage.bottomAnchor, right: nil, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 120, height: 50)
        footerContainer.insertArrangedSubview(likePost, at: 0)
        footerContainer.insertArrangedSubview(postComment, at: 1)
        footerContainer.insertArrangedSubview(sharePost, at: 2)
        
        savePost.anchors(top: postImage.bottomAnchor, right: rightAnchor, bottom: nil, left: nil, paddingTop: 0, paddingRight: -8, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        savePost.centerYAnchor.constraint(equalTo: footerContainer.centerYAnchor).isActive = true
        
        commentsContainer.anchors(top: footerContainer.bottomAnchor, right: rightAnchor, bottom: nil, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        commentsContainer.insertArrangedSubview(postCaption, at: 0)
        commentsContainer.insertArrangedSubview(postDate, at: 1)
        
    }
    
    func loadPost(){
        if let post = post{
            if let url = post.url{
                if let cachedImage = imageCache[url.absoluteString]{
                    self.postImage.image = cachedImage
                    return
                }
                
                loadImageWith(url: url, completion: { [weak self] (data) in
                    self?.imageCache[url.absoluteString] = UIImage(data: data)
                    DispatchQueue.main.async {
                        self?.postImage.image = UIImage(data: data)
                    }
                })
            }
        }
    }
    
    fileprivate func loadImageWith(url imageUrl: URL, completion: ((_ data:Data)->Void)?){
        let session = URLSession(configuration: .default)
        session.dataTask(with: imageUrl) { (data, response, error) in
            if let error = error{
                print(error)
                return
            }
            if let data = data{
                if let completion = completion{
                    completion(data)
                }
            }
            }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
