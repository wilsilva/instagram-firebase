//
//  AddPhotosNavigationController.swift
//  Instagram
//
//  Created by tiago turibio on 10/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class AddPhotosNavigationController: MainMenuNavigationController {
    
    override func executeBeforeShowing() -> Bool {
        let imageSelector = UISeparateNavigationController(rootViewController: ImageSelectionController())
        present(imageSelector, animated: true, completion: nil)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.image = #imageLiteral(resourceName: "plus_unselected")
    }
}
