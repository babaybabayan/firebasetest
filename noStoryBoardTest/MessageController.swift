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
        view.backgroundColor = .white
        
        print("AUTHOK",Auth.auth().currentUser?.uid as Any)
        if Auth.auth().currentUser?.uid == nil {
            handelLogout()
        }
    }
    
    func checkIfUserLoggedIn(){
        
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
