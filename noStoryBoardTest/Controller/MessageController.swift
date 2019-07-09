//
//  MessageController.swift
//  noStoryBoardTest
//
//  Created by Fivecode on 05/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import Firebase

class MessageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let db = Database.database().reference().child("ChatDatabase")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handelLogout))
        let imageNewMessage = UIImage(named: "ic_newmessage")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageNewMessage, style: .plain, target: self, action: #selector(handleNewMessage))
        view.backgroundColor = .white
        
        print("AUTHOK",Auth.auth().currentUser?.uid as Any)
        checkIfUserLoggedIn()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfUserLoggedIn()
    }
    
    @objc func handleNewMessage(){
        let newMessageController = NewMessageTableViewController()
        let navigationControl = UINavigationController(rootViewController: newMessageController)
        present(navigationControl, animated: true, completion: nil)
    }
    
    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handelLogout), with: nil, afterDelay: 0)
        }else{
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("Register").child(uid!).observe(.value) { (snapshot) in
                
                
                if let dictonary = snapshot.value as? [String: AnyObject]{
                    let users = Users()
                    users.name = dictonary["Name"] as? String
                    users.profileImageUrl = dictonary["ProfileImageUrl"] as? String
                    self.setupViewNavigation(user: users)
                }
                
            }
        }
    }
    
    func setupViewNavigation(user: Users){
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(containerView)
        
        self.navigationItem.titleView = titleView
        
        let profileImageView = UIImageView()
        containerView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 20
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.loadImageUseCache(urlString: profileImageUrl)
        }
        //addContraint ProfileImageView
        
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let titleLabel = UILabel()
        containerView.addSubview(titleLabel)
        titleLabel.text = user.name
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //addcontraint title Label
        titleLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        
    }
    
    @objc func handelLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch  {
            print(error)
        }
        
        let viewControl = ViewController()
        present(viewControl, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
