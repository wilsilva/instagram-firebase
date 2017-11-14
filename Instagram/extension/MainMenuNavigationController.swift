//
//  MainMenuNavigationController.swift
//  Instagram
//
//  Created by tiago turibio on 13/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class MainMenuNavigationController: UINavigationController,MainMenuNavigationProtocol {
    func executeBeforeShowing() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
