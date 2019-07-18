//
//  UsersCell.swift
//  noStoryBoardTest
//
//  Created by Fivecode on 18/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit
import Firebase

class UsersCell: UITableViewCell {
    
    var message: Message? {
        didSet {
            if let toId = message?.toId {
                let ref = Database.database().reference().child("Register").child(toId)
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dictonary = snapshot.value as? [String: AnyObject] {
                        self.textLabel?.text = dictonary["Name"] as? String
                        
                        if let profileImge = dictonary["ProfileImageUrl"] as? String {
                            
                            self.profilImage.loadImageUseCache(urlString: profileImge)
                            
                        }
                    }
                }, withCancel: nil)
            }
            
            detailTextLabel?.text = message?.text
            
            //dateformatter from timestamp
            if let second = message?.timeStamp?.doubleValue {
                let timeStampDate = NSDate(timeIntervalSince1970: second)
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateformatter.string(from: timeStampDate as Date)
            }
        }
    }
    
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
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "tanggal"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profilImage)
        addSubview(timeLabel)
        //addconstraint profileimageview
        profilImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profilImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profilImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profilImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: textLabel!.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
