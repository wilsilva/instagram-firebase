//
//  ViewController.swift
//  Instagram
//
//  Created by tiago turibio on 26/10/17.
//  Copyright © 2017 tiago turibio. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    enum LoginErro: Error{
        case emptyUsername
        case invalidEmail
        case invalidPassword
    }
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 0, alpha: 0.2)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.addTarget(self, action: #selector(validateSignUpForm), for: .editingChanged)
        return textField
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 0, alpha: 0.2)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.addTarget(self, action: #selector(validateSignUpForm), for: .editingChanged)
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
        textField.addTarget(self, action: #selector(validateSignUpForm), for: .editingChanged)
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
        bt.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.layer.cornerRadius = 5
        bt.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return bt
    }()
    
    @objc func addPhoto(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var profileImage: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEdited Image"] as? UIImage{
            profileImage = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            profileImage = originalImage
        }
        
        profileImage = profileImage?.withRenderingMode(.alwaysOriginal)
        setProfileImage(profileImage!, button: addPhotoButton)
        dismiss(animated: true, completion: nil)
    }
    
    private func setProfileImage(_ image: UIImage, button: UIButton){
        button.setRoundImage(image, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
    }
    
    @objc func signUpAction(){
        do{
            let email = emailTextField.text!
            let username = usernameTextField.text!
            let password = passwordTextField.text!
            try signUp(email, username: username, password: password)
        }catch LoginErro.emptyUsername{
            usernameTextField.shake()
            usernameTextField.becomeFirstResponder()
        }catch LoginErro.invalidEmail{
            emailTextField.shake()
            emailTextField.becomeFirstResponder()
        }catch LoginErro.invalidPassword{
            passwordTextField.shake()
            passwordTextField.becomeFirstResponder()
        }catch{
            Alert.showBasic("Login Error", message: "Sorry, there was an error processing your signup proccess", viewController: self)
        }
    }
    
    @objc func validateSignUpForm(){
        let anyEmpty = anyEmptyTextField(usernameTextField,passwordTextField,emailTextField)
        signUpButton.setAsEnabled(!anyEmpty)
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
    
    private func signUp(_ email: String, username: String, password: String) throws{
        
        if !email.isValidEmail(){
            throw LoginErro.invalidEmail
        }
        
        if username.count <= 0{
            throw LoginErro.emptyUsername
        }
        
        if password.count < 6{
            throw LoginErro.invalidPassword
        }
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] (user, error) in
            if let error = error{
                Alert.showBasic("Login Error", message: error.localizedDescription, viewController: self!)
            }else{
                
                guard let image = self?.getProfileImage() else{ return }
                guard let uploadData = UIImagePNGRepresentation(image) else { return }
                
                let filename = NSUUID().uuidString
                
                Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil, completion: { (storageMetadata, error) in
                    if let error = error{
                        Alert.showBasic("Firabase storage error", message: error.localizedDescription, viewController: self!)
                        return
                    }
                    
                    guard let uid = user?.uid else {return}
                    let userInfoDictionary = ["username":username,"userProfilePicture": storageMetadata?.downloadURL()?.absoluteString]
                    let values = [uid:userInfoDictionary]
                    
                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, databaseReference) in
                        if let error = error{
                            Alert.showBasic("Firabase storage error", message: error.localizedDescription, viewController: self!)
                            return
                        }
                    })
                })
            }
        }
    }
    
    private func getProfileImage() -> UIImage?{
        return addPhotoButton.currentImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputFieldsStackView.insertArrangedSubview(emailTextField, at: 0)
        inputFieldsStackView.insertArrangedSubview(usernameTextField, at: 1)
        inputFieldsStackView.insertArrangedSubview(passwordTextField, at: 2)
        inputFieldsStackView.insertArrangedSubview(signUpButton, at: 3)
        
        view.addSubview(addPhotoButton)
        view.addSubview(inputFieldsStackView) 
        
        addPhotoButton.anchors(top: view.topAnchor, topConstant: 40, right: nil, rightConstant: 0, bottom: nil, bottomConstant: 0, left: nil, leftConstant: 0, width: 140, height: 140)
        
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        inputFieldsStackView.anchors(top: addPhotoButton.bottomAnchor, topConstant: 20, right: view.rightAnchor, rightConstant: -40, bottom: nil, bottomConstant: 0, left: view.leftAnchor, leftConstant: 40, width: nil, height: 200)
        
        validateSignUpForm()
        
    }
}

