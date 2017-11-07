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
    func anchors( top: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,paddingTop: CGFloat, paddingRight: CGFloat, paddingBottom: CGFloat, paddingLeft: CGFloat, width: CGFloat?, height: CGFloat?){
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let right = right{
         self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let width = width{
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height{
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension UITextField{
    func shake(){
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 5
        shakeAnimation.autoreverses = true
        let fromValueAnimationCoordenates = CGPoint(x: self.center.x - 12, y: self.center.y)
        let toValueAnimationCoordenates = CGPoint(x: self.center.x, y: self.center.y)
        shakeAnimation.fromValue = NSValue(cgPoint: fromValueAnimationCoordenates)
        shakeAnimation.toValue = NSValue(cgPoint: toValueAnimationCoordenates)
        self.layer.add(shakeAnimation, forKey: "position")
    }
}

extension String{
    func isValidEmail() -> Bool{
        let emailValidationRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailPredicate.evaluate(with:self)
    }
}

extension UIButton{
    func setAsEnabled(_ enabled: Bool){
        self.isEnabled = enabled
        if enabled{
            self.alpha = 1
        }else{
            self.alpha = 0.5
        }
    }
    
    func setRoundImage(_ image: UIImage?, for state: UIControlState ){
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
        self.setImage(image, for: state)
    }
}
