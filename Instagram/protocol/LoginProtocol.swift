//
//  LoginProtocol.swift
//  Instagram
//
//  Created by tiago turibio on 11/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import Foundation
import UIKit

protocol LoginControllerProtocol{
    func handleLogin(email: String, password: String)
    func validateLogin(email: String, password: String)
    func handleSignUp()
    func setLoginButtonState(as enabled: Bool)
}

protocol LoginViewProtocol{
    init(controller: LoginControllerProtocol)
    func shakeEmailButton()
    func shakePasswordButton()
    func setLoginButtonState(as enabled: Bool)
}
