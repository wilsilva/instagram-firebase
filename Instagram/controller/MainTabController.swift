//
//  MainTabController.swift
//  Instagram
//
//  Created by tiago turibio on 06/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.black
        self.view.backgroundColor = UIColor.white
        
        if !isAuthenticated(Auth.auth().currentUser){
            DispatchQueue.main.async { [weak self] in
                self?.present(LoginNavigationController(), animated: true, completion: nil)
            }
            
            return
        }
        
        let controllersList = getControllersList()
        addViewControllers(controllersList)
        if let items = tabBar.items{
            adjustsTabBarIcons(items)
        }
    }
    
    func getControllersList() -> [UIViewController]{
        let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        let userProfileNavigationController = UserProfileNavigationController(rootViewController: userProfileController)
        let homeNavigationController = HomeNavigationController(rootViewController: UIViewController())
        let searchNavigationController = SearchNavigationController(rootViewController: UIViewController())
        let addPhotosNavigationController = AddPhotosNavigationController(rootViewController: UIViewController())
        let favouritesNavigationController = FavouritesNavigationController(rootViewController: UIViewController())
        return [userProfileNavigationController,homeNavigationController,searchNavigationController,addPhotosNavigationController,favouritesNavigationController]
    }
    
    func addViewControllers(_ controllers: [UIViewController]){
        self.viewControllers = controllers
    }
    
    func adjustsTabBarIcons(_ items: [UITabBarItem]){
        for item in items{
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    func isAuthenticated(_ currentUser: Firebase.User?) -> Bool{
        return currentUser != nil
    }
}
