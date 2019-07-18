//
//  NewMessageTableViewController.swift
//  noStoryBoardTest
//
//  Created by Fivecode on 06/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class NewMessageTableViewController: UITableViewController {

    var users = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cencel", style: .plain, target: self, action: #selector(handleCencel))
        
        tableView.register(UsersCell.self, forCellReuseIdentifier: "cellId")
        
        fetchUser()
    }

    // MARK: - Table view data source
    func fetchUser() {
        SVProgressHUD.show()
        Database.database().reference().child("Register").observe(.childAdded
            , with: { (snapshot) in
                
                if let dictonary = snapshot.value as? [String: AnyObject] {
                    let user = Users()
                    user.id = snapshot.key
                    user.name = dictonary["Name"] as? String
                    user.email = dictonary["Email"] as? String
                    user.profileImageUrl = dictonary["ProfileImageUrl"] as? String
                    self.users.append(user)
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                }
                
                
        }, withCancel: nil)
    }
    
    @objc func handleCencel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! UsersCell
        
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = users[indexPath.row].email
        
        let user = users[indexPath.row]
        
        if let profileImage = user.profileImageUrl {
            cell.profilImage.loadImageUseCache(urlString: profileImage)
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    var msgController: MessageController?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            let user = self.users[indexPath.row]
            self.msgController?.showChatControllerForUser(user: user)
        }
    }
}
