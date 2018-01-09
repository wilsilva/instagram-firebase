//
//  HomeControllerViewController.swift
//  Instagram
//
//  Created by tiago turibio on 19/12/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit
import Photos
import Firebase
class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    
    let titleView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "Instagram_logo_white").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate func fetchPosts(completion: ((_ post: Post) -> Void)?){
        guard Auth.auth().currentUser?.uid != nil else {return}
        Database.database().reference().child("users").observeSingleEvent(of: .value) { (snapShot) in
            for child in snapShot.children{
                if let userSnapshot = child as? DataSnapshot,let user = User(snapshot: userSnapshot){
                    Database.database().reference().child("posts").child(userSnapshot.key).queryOrdered(byChild: "creationDate").observeSingleEvent(of: .value) {(snapShot) in
                        for child in snapShot.children{
                            if let postSnapShot = child as? DataSnapshot, let post = Post(snapshot: postSnapShot){
                                post.user = user
                                if let completion = completion{
                                    completion(post)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        self.collectionView?.numberOfItems(inSection: 0)
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: PostCell.ID)
        fetchPosts(completion: loadPost)
        setupNavigationItems()
    }
    
    fileprivate func loadPost(post: Post){
        DispatchQueue.main.async { [weak self] in
            self?.posts.append(post)
            self?.collectionView?.numberOfItems(inSection: 0)
            self?.collectionView?.insertItems(at: [IndexPath(row: self!.posts.endIndex - 1, section: 0)])
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.ID, for: indexPath)
        if let postCell = cell as? PostCell{
            postCell.post = posts[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.width + 60 + 50 + 80
        return CGSize(width: view.frame.width, height: height)
    }
    
    fileprivate func setupNavigationItems(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera3").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)
        navigationItem.titleView = titleView
    }
}
