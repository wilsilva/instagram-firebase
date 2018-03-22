//
//  CommentsViewController.swift
//  Instagram
//
//  Created by tiago turibio on 21/03/18.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import UIKit
import Firebase

class CommentsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var post: Post?{
        didSet{
            fetchComments(post:post!,completion:loadComment)
        }
    }
    
    var comments = [Comment]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.collectionView?.backgroundColor = .white
        // Register cell classes
        self.collectionView!.register(CommentsViewCell.self, forCellWithReuseIdentifier: CommentsViewCell.ID)
    }
    
    fileprivate func loadComment(comment: Comment){
        DispatchQueue.main.async { [weak self] in
           self?.comments.append(comment)
           self?.collectionView?.reloadData()
        }
    }
    
    fileprivate func fetchComments(post: Post, completion: ((_ comment:Comment) -> Void)?){
        if let postID = post.uid{
            Database.database().reference().child("comments").child(postID).observe(.value) { (snapshot) in
                snapshot.children.forEach({ (value) in
                    if let commentSnapshot = value as? DataSnapshot{
                        if let comment = Comment(snapshot: commentSnapshot  ), let userID = comment.userID{
                            Database.fetchUser(with: userID, completion: { (user) in
                                comment.user = user
                                if let completion = completion{
                                    completion(comment)
                                }
                            })
                        }
                    }
                })
            }
        }
    }
    
    fileprivate func setupViews(){
        self.title = NSLocalizedString("comments", comment: "")
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentsViewCell.ID, for: indexPath)
        if let commentCell = cell as? CommentsViewCell{
            commentCell.comment = comments[indexPath.row]
        }
        return cell
    }
}
