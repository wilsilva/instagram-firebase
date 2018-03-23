//
//  CommentsTableViewController.swift
//  Instagram
//
//  Created by tiago turibio on 22/03/18.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import UIKit
import Firebase

class CommentsTableViewController: UITableViewController {
   
    var comments = [Comment]()
    
    var post: Post?{
        didSet{
            fetchComments(post:post!,completion:loadComment)
        }
    }
    
    fileprivate func loadComment(comment: Comment){
        DispatchQueue.main.async { [weak self] in
            self?.comments.append(comment)
            self?.tableView?.reloadData()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .white
        self.tableView.register(CommentsViewCell.self, forCellReuseIdentifier: CommentsViewCell.ID)
        setupViews()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentsViewCell.ID, for: indexPath)
        
        if let commentCell = cell as? CommentsViewCell{
            commentCell.comment = self.comments[indexPath.row]
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
