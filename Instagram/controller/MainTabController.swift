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
        self.view.backgroundColor = UIColor.white
        
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async { [weak self] in
                self?.present(LoginNavigationController(), animated: true, completion: nil)
            }
            return
        }
        
        let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: userProfileController)
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        tabBar.tintColor = UIColor.black
        viewControllers = [navigationController,UIViewController()]
    }
}
