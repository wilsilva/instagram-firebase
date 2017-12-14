//
//  Post.swift
//  Instagram
//
//  Created by tiago henrique on 14/12/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import Foundation
import Firebase
class Post: NSObject{
    var imageCaption: String?
    var imageURL: URL?
    var uid: String?
    
    init?(snapshot: DataSnapshot) {
        guard let uid = snapshot.key as? String else{return nil}
        guard let snapshot = snapshot.value as? [String: Any] else{return nil}
        guard let imageCaption = snapshot["imageCaption"] as? String else{return nil}
        guard let imageURL = snapshot["imageURL"] as? String else{return nil}
        
        self.uid = uid
        self.imageCaption = imageCaption
        self.imageURL = URL(string: imageURL)
    }
}
