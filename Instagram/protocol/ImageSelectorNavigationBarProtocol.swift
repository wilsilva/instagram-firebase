//
//  ImageSelectorNavigationBarProtocol.swift
//  Instagram
//
//  Created by tiago henrique on 22/11/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import Foundation
import UIKit

protocol ImageSelectorNavigationBarProtocol{
    var leftBarButtonItem: ImageSelectorNavigationBarItem?{get set}
    var rightBarButtonItem: ImageSelectorNavigationBarItem?{get set}
}
