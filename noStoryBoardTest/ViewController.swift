//
//  ViewController.swift
//  noStoryBoardTest
//
//  Created by Fivecode on 05/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    let inputContainerView: UIView = {
        let view  = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let buttonRegister: UIButton = {
        let register = UIButton(type: .system)
        register.setTitle("Register", for: .normal)
        register.setTitleColor(UIColor.white, for: .normal)
        register.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        register.layer.cornerRadius = 5
        register.translatesAutoresizingMaskIntoConstraints = false
        
        register.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        
        return register
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let nameSepartor: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailSepartor: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "eagleLogo")
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let loginRegisterSegmenControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login","Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLogonRegisterChance), for: .valueChanged)
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(inputContainerView)
        view.addSubview(buttonRegister)
        view.addSubview(logoImage)
        view.addSubview(loginRegisterSegmenControl)
        
        setupViewContainer()
        setupRegisterBtn()
        setupImageView()
        setipSegmenControl()
    }
    
    var inputContainerHeightAcnchor: NSLayoutConstraint?
    var nameTextfieldHeightAnchor: NSLayoutConstraint?
    var emailTextfieldHeightAnchor: NSLayoutConstraint?
    var passwordTextfieldHeightAnchor: NSLayoutConstraint?
    
    func setupViewContainer(){
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerHeightAcnchor =  inputContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputContainerHeightAcnchor?.isActive = true
        
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSepartor)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(emailSepartor)
        inputContainerView.addSubview(passwordTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameTextfieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        nameTextfieldHeightAnchor?.isActive = true
        
        nameSepartor.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSepartor.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        nameSepartor.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameSepartor.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: nameSepartor.bottomAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailTextfieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        emailTextfieldHeightAnchor?.isActive = true
        
        emailSepartor.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSepartor.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        emailSepartor.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailSepartor.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailSepartor.bottomAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordTextfieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        passwordTextfieldHeightAnchor?.isActive = true
        
    }
    
    func setupRegisterBtn(){
        buttonRegister.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonRegister.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        buttonRegister.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        buttonRegister.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupImageView(){
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.bottomAnchor.constraint(equalTo: loginRegisterSegmenControl.topAnchor, constant: 10).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setipSegmenControl(){
        loginRegisterSegmenControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmenControl.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmenControl.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegisterSegmenControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func handleLoginRegister(){
        if loginRegisterSegmenControl.selectedSegmentIndex == 0 {
            handleLogin()
        }else{
            handleRegister()
        }
    }
    
    func handleLogin(){
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print("Error Logged in: \(error!)")
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            
            print("Success Create Auth !!!")
            
            let ref = Database.database().reference().child("Register")
            let values = ["Name": name, "Email": email]
            
            ref.childByAutoId().setValue(values, withCompletionBlock: { (error, reference) in
                if error != nil {
                    print(error!)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
        
            })
            
        }
    }
    
    @objc func handleLogonRegisterChance(){
        let namedSegment = loginRegisterSegmenControl.titleForSegment(at: loginRegisterSegmenControl.selectedSegmentIndex)
        buttonRegister.setTitle(namedSegment, for: .normal)
        
        inputContainerHeightAcnchor?.constant = loginRegisterSegmenControl.selectedSegmentIndex == 0 ? 100 : 150
        
        nameTextfieldHeightAnchor?.isActive = false
        nameTextfieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmenControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextfieldHeightAnchor?.isActive = true
        
        emailTextfieldHeightAnchor?.isActive = false
        emailTextfieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmenControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextfieldHeightAnchor?.isActive = true
        
        passwordTextfieldHeightAnchor?.isActive = false
        passwordTextfieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmenControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextfieldHeightAnchor?.isActive = true
    }
}


extension UIColor {
    convenience init(r:CGFloat, g: CGFloat, b: CGFloat ) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

