//
//  LoginNavigationController.swift
//  Instagram
//
//  Created by tiago henrique on 09/11/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class LoginNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let loginController = LoginController()
        self.viewControllers = [loginController]
    }
}
