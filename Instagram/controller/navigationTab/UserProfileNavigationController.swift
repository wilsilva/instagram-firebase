//
//  UserProfileNavigationController.swift
//  Instagram
//
//  Created by tiago turibio on 10/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class UserProfileNavigationController: MainMenuNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        self.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
    }
}
