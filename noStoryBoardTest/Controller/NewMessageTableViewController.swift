//
//  NewMessageTableViewController.swift
//  noStoryBoardTest
//
//  Created by Fivecode on 06/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit
import Firebase

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
        Database.database().reference().child("Register").observe(.childAdded
            , with: { (snapshot) in
                
                if let dictonary = snapshot.value as? [String: AnyObject] {
                    let user = Users()
                    
                    user.name = dictonary["Name"] as? String
                    user.email = dictonary["Email"] as? String
                    user.profileImageUrl = dictonary["ProfileImageUrl"] as? String
                    self.users.append(user)
                    
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

}

class UsersCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 56, y: (textLabel?.frame.origin.y)!, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        detailTextLabel?.frame = CGRect(x: 56, y: (detailTextLabel?.frame.origin.y)!, width: (detailTextLabel?.frame.width)!, height: (detailTextLabel?.frame.height)!)
    }
    
    let profilImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = ContentMode.scaleToFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profilImage)
        
        //addconstraint profileimageview
        profilImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profilImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profilImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profilImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
