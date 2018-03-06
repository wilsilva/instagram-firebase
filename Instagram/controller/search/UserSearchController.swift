//
//  UserSearchController.swift
//  Instagram
//
//  Created by tiago henrique on 05/03/2018.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import UIKit
import Firebase

class UserSearchController: UICollectionViewController,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    var users = [User]()
    var filteredUsers = [User]()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = NSLocalizedString("search_placeholder", comment: "")
        search.searchBarStyle = .minimal
        search.barTintColor = .gray
        search.delegate = self
        return search
    }()

    private func setupViews(){
        navigationItem.titleView = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(UserSearchCellCollectionViewCell.self, forCellWithReuseIdentifier:UserSearchCellCollectionViewCell.ID)
        setupViews()
        fetchUsers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserSearchCellCollectionViewCell.ID, for: indexPath)
        if let searchCell = cell as? UserSearchCellCollectionViewCell{
            let user = self.filteredUsers[indexPath.row]
            searchCell.user = user
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    fileprivate func fetchUsers(){
        Database.database().reference().child("users").queryOrdered(byChild: "name").observeSingleEvent(of: .value) { (snapshot) in
            snapshot.children.forEach({ (value) in
                if let userSnapshot = value as? DataSnapshot{
                    if let user = User(snapshot: userSnapshot){
                        self.users.append(user)
                    }
                }
            })
            self.filteredUsers = self.users
            self.collectionView?.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty{
            self.filteredUsers = self.users
        }else{
            self.filteredUsers = users.filter { (user) -> Bool in
                return user.name!.lowercased().contains(searchText.lowercased())
            }
        }
        
        collectionView?.reloadData()
    }
}
