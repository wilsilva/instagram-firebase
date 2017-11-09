//
//  LoginController.swift
//  Instagram
//
//  Created by tiago henrique on 09/11/2017.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    enum LoginError: Error{
        case invalidEmail
        case invalidPassword
    }
    
    let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    let bluBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 0, alpha: 0.2)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(validateLogin), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 0, alpha: 0.2)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(validateLogin), for: .editingChanged)
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        let normalText = "Don't have an account? "
        let boldText = "Sign Up"
        let buttonText = NSMutableAttributedString(string:normalText, attributes: [.foregroundColor: UIColor.black])
        let attributedString = NSMutableAttributedString(string: boldText, attributes: [.font : UIFont.boldSystemFont(ofSize: 15), .foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)])
        
        buttonText.append(attributedString)
        button.setAttributedTitle(buttonText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSignUp(){
        navigationController?.pushViewController(SignupController(), animated: true)
    }
    
    @objc func handleLogin(){
        let email = emailTextField.text!
        let password = passwordTextField.text!
        do {
            try login(withEmail: email, password: password)
        }catch LoginError.invalidEmail{
            emailTextField.shake()
            emailTextField.becomeFirstResponder()
        }catch LoginError.invalidPassword{
            passwordTextField.shake()
            passwordTextField.becomeFirstResponder()
        }catch{
            Alert.showBasic("Login Error", message: "Sorry, there was while trying to log you in. Please try again later.", viewController: self, handler: nil)
        }
    }
    
    func login(withEmail email: String, password: String) throws{
        
        if !email.isValidEmail(){
            throw LoginError.invalidEmail
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if let error = error{
                Alert.showBasic("Login Error", message: error.localizedDescription, viewController: self!, handler: nil)
                return
            }
            self?.navigationController?.pushViewController(MainTabController(), animated: true)
        }
    }
    
    @objc func validateLogin(){
        let anyEmpty = anyEmptyTextField(emailTextField,passwordTextField)
        loginButton.setAsEnabled(!anyEmpty)
    }
    
    private func anyEmptyTextField(_ uiTextFields: UITextField...) -> Bool{
        var isEmpty = false
        for uiTextField in uiTextFields {
            if uiTextField.text!.count <= 0{
                isEmpty = true
            }
        }
        return isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(loginStackView)
        view.addSubview(signUpButton)
        view.addSubview(bluBackground)
        
        navigationController?.isNavigationBarHidden = true
        
        validateLogin()
        
        bluBackground.anchors(top: view.topAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 200)
        
        loginStackView.insertArrangedSubview(emailTextField, at: 0)
        loginStackView.insertArrangedSubview(passwordTextField, at: 1)
        loginStackView.insertArrangedSubview(loginButton, at: 2)
        loginStackView.anchors(top: bluBackground.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 40, paddingRight: -20, paddingBottom: 0, paddingLeft: 20, width: 0, height: 150)
        
        signUpButton.anchors(top: nil, right: nil, bottom: view.bottomAnchor, left: nil, paddingTop: 0, paddingRight: 0, paddingBottom: -10, paddingLeft: 0, width: 0, height: 0)
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
