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
        }
    }
    
    var photoCellId = "photoCellId"
    
    enum FetchUserError: Error{
        case notLoggedIn
    }
    
    var userProfilePictureURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: UserProfileHeader.ID)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: photoCellId)
        setupNavigationItem(navigationItem)
        do {
           try fetchUser()
        }catch FetchUserError.notLoggedIn{
            Alert.showBasic("User Info Error", message: "Sorry, but looks like you're not logged in. Please try logging in to continue.", viewController: self, handler: { [weak self] (alertAction) in
                self?.dismiss(animated: true, completion:nil)
                self?.present(SignupController(), animated: true, completion: nil)
            })
        }catch{
            Alert.showBasic("User Info Error", message: error.localizedDescription, viewController: self, handler: nil)
        }
    }
    
    fileprivate func fetchUser() throws{
        guard let userUID = Auth.auth().currentUser?.uid else { throw FetchUserError.notLoggedIn }
        Database.database().reference().child("users").child(userUID).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            self?.user = User(snapshot: snapshot)
            self?.collectionView?.reloadData()
        }) { (error) in
            Alert.showBasic("Get user info error", message: error.localizedDescription, viewController: self, handler: nil)
        }
    }
    
    fileprivate func setupNavigationItem(_ navigationItem: UINavigationItem){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] (_) in
            do{
                try Auth.auth().signOut()
                self?.present(LoginNavigationController(), animated: true, completion: nil)
            }catch let signOutError as NSError{
                Alert.showBasic("Sign Out error", message: signOutError.localizedDescription, viewController: self!, handler: nil)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        
        present(alertController, animated: true, completion: nil)
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellId, for: indexPath)
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Horizontal and vertical spacing between cells is 1 pixel each
        let size = (self.view.frame.width - 2) / 3
        return CGSize(width: size , height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
