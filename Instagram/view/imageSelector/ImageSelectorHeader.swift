//
//  ImageSelectorHeader.swift
//  Instagram
//
//  Created by tiago henrique on 14/11/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

enum ScrollDirection {
    case Up
    case Down
}

enum ScrollState {
    case enabled
    case disabled
}

enum HeaderState {
    case opened
    case closed
}

class ImageSelectorHeader: UIView {
    static var ID = "imageSelectorHeaderId"
    static let scrollablFrameHeight: CGFloat = 44
    
    let selectedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let blackForeground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        return view
    }()
    
    let scrollableFrame: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(selectedImage)
        self.addSubview(blackForeground)
        self.addSubview(scrollableFrame)
        self.translatesAutoresizingMaskIntoConstraints = false
        selectedImage.anchors(top: topAnchor, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        blackForeground.anchors(top: topAnchor, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        scrollableFrame.anchors(top: nil, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: ImageSelectorHeader.scrollablFrameHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
