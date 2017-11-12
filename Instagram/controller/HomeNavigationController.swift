//
//  HomeNavigationController.swift
//  Instagram
//
//  Created by tiago turibio on 10/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class HomeNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.image = #imageLiteral(resourceName: "home_unselected")
        self.tabBarItem.selectedImage = #imageLiteral(resourceName: "home_selected")
    }
}
