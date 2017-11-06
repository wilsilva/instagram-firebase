//
//  Alert.swift
//  Instagram
//
//  Created by tiago turibio on 02/11/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import Foundation
import UIKit

class Alert{
    
    static func showBasic(_ title: String, message: String, viewController: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
