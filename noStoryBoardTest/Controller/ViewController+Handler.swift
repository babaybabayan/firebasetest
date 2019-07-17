//
//  ViewController+Handler.swift
//  noStoryBoardTest
//
//  Created by Fivecode on 06/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func handleImagePicker() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImagePicker: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImagePicker = editedImage
        }else if let originalImage = info[.originalImage] as? UIImage{
            selectedImagePicker = originalImage
        }
        
        if let selectedImage = selectedImagePicker {
            logoImage.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func handleRegister() {
        SVProgressHUD.show()
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
                return
            }
            
            print("Success Create User !!!")
            
            //save image storage
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("Register").child("\(imageName).jpg")
            if let uploadData = self.logoImage.image!.jpegData(compressionQuality: 0.1){
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print("Error",error!)
                        return
                    }
                    print("Success Upload Image")
                    storageRef.downloadURL(completion: { (imageUrl, err) in
                        print("imageurl",imageUrl!)
                        guard let uid = Auth.auth().currentUser?.uid else { return }
                        let values = ["Name": name, "Email": email, "ProfileImageUrl": imageUrl!.absoluteString] as [String : AnyObject]
                        self.registerUserIntoDatabaewithUID(uid: uid, values: values as [String : AnyObject])
                    })
                })
            }
        }
    }
    
    func registerUserIntoDatabaewithUID(uid: String, values:[String:AnyObject]) {
        SVProgressHUD.show()
        let ref = Database.database().reference().child("Register")
        ref.child(uid).setValue(values, withCompletionBlock: { (error, reference) in
            if error != nil {
                print(error!)
                return
            }
            print("Success Create Database")
            self.dismiss(animated: true, completion: nil)
            SVProgressHUD.dismiss()
            
        })
    }
}
