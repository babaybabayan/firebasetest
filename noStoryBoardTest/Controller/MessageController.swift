//
//  MessageController.swift
//  noStoryBoardTest
//
//  Created by Fivecode on 05/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit
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
                if let dictonary = snapshot.value as? [String:AnyObject] {
                    self.navigationItem.title = dictonary["Name"] as? String
                }
            }
        }
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
