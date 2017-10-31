//
//  ViewController.swift
//  Instagram
//
//  Created by tiago turibio on 26/10/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 0, alpha: 0.2)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 0, alpha: 0.2)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 0, alpha: 0.2)])
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }()
    
    let inputFieldsStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let signUpButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Sign Up", for: .normal)
        bt.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.layer.cornerRadius = 5
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputFieldsStackView.insertArrangedSubview(emailTextField, at: 0)
        inputFieldsStackView.insertArrangedSubview(usernameTextField, at: 1)
        inputFieldsStackView.insertArrangedSubview(passwordTextField, at: 2)
        inputFieldsStackView.insertArrangedSubview(signUpButton, at: 3)
        
        view.addSubview(addPhotoButton)
        view.addSubview(inputFieldsStackView)
        
        addPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        inputFieldsStackView.anchors(top: addPhotoButton.bottomAnchor, topConstant: 20, right: view.rightAnchor, rightConstant: -40, bottom: nil, bottomConstant: 0, left: view.leftAnchor, leftConstant: 40)
        
        inputFieldsStackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

