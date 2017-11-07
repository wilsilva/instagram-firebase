//
//  UserProfileController.swift
//  Instagram
//
//  Created by tiago turibio on 06/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user: User?{
        didSet{
            navigationItem.title = user?.name
            collectionView?.reloadData()
        }
    }
    
    enum FetchUserError: Error{
        case notLoggedIn
    }
    
    var userProfilePictureURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: UserProfileHeader.ID)
        
        do {
           try fetchUser()
        }catch FetchUserError.notLoggedIn{
            Alert.showBasic("User Info Error", message: "Sorry, but looks like you're not logged in. Please try logging in to continue.", viewController: self)
        }catch{
            Alert.showBasic("User Info Error", message: error.localizedDescription, viewController: self)
        }
    }
    
    fileprivate func fetchUser() throws{
        guard let userUID = Auth.auth().currentUser?.uid else { throw FetchUserError.notLoggedIn }
        Database.database().reference().child("users").child(userUID).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            self?.user = User(snapshot: snapshot)
        }) { (error) in
            Alert.showBasic("Get user info error", message: error.localizedDescription, viewController: self)
        }
    }
    
    func setTitle(_ title: String){
        navigationItem.title = title
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UserProfileHeader.ID, for: indexPath)
        if let userProfileHeader = header as? UserProfileHeader{
            userProfileHeader.user = self.user
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
}
