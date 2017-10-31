//
//  Extension.swift
//  Instagram
//
//  Created by tiago turibio on 30/10/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView{
    func anchors( top: NSLayoutYAxisAnchor?, topConstant: CGFloat, right: NSLayoutXAxisAnchor?, rightConstant: CGFloat, bottom: NSLayoutYAxisAnchor?, bottomConstant: CGFloat, left: NSLayoutXAxisAnchor?, leftConstant: CGFloat){
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let right = right{
         self.rightAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
        }
        
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }
        
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
    }
}
