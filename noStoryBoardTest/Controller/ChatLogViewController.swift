//
//  ChatLogViewController.swift
//  noStoryBoardTest
//
//  Created by Fivecode on 12/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit
import Firebase
class ChatLogViewController: UICollectionViewController, UITextFieldDelegate {
    
    lazy var inputTextField: UITextField = {
        let textView = UITextField()
        textView.placeholder = "Enter Message ..."
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var heighAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chat Log"
        collectionView.backgroundColor = .white
        inputTextField.delegate = self
        setupInputComponent()
        hideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupInputComponent() {

        view.addSubview(containerView)
        //contraint
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        heighAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        heighAnchor?.isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(handleMessage), for: .touchUpInside)
        //sendButton.backgroundColor = .white
        containerView.addSubview(sendButton)
        //contraint
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(inputTextField)
        //contraint
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let seperatorView = UIView()
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        seperatorView.backgroundColor = .gray
        containerView.addSubview(seperatorView)
        //contraint
        seperatorView.bottomAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        inputTextField.resignFirstResponder()
    }
    
    @objc func handleMessage() {
        let ref = Database.database().reference().child("Messages")
        let childId = ref.childByAutoId()
        let values = ["textMessage": inputTextField.text!, "Name": "Akbar Z"] as [String : Any]
        childId.updateChildValues(values) { (err, referensi) in
            if err != nil {
                print(err!)
                return
            }
            print("Messege Sent")
            self.inputTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleMessage()
        return true
    }
    
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

extension ChatLogViewController {
    
    @objc func keyboardWillShow(notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = UIScreen.main.bounds.height - keyboardRectangle.height
            heighAnchor?.constant = keyboardHeight - UIScreen.main.bounds.height
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let _ : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            heighAnchor?.constant = 0
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
