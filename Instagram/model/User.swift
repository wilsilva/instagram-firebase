//
//  User.swift
//  Instagram
//
//  Created by tiago henrique on 07/11/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject{
    var name: String?
    var profilePictureURL: URL?
    
    init?(snapshot: DataSnapshot) {
        guard let snapshot = snapshot.value as? [String: Any] else{return nil}
        guard let username = snapshot["username"] as? String else{return nil}
        guard let userProfilePicture = snapshot["userProfilePicture"] as? String else{return nil}
        
        self.name = username
        self.profilePictureURL = URL(string: userProfilePicture)
    }
}
