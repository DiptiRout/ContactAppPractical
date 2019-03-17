//
//  ContactDetailsViewController.swift
//  ContactAppPractical
//
//  Created by Muvi on 17/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UITableViewController {
    
    let cellID = "ContactEditCell"
    var editOption: ContactEditOption!
    var contactDetails: ContactDetails!


    @IBOutlet weak var headerImageView: CachedImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var msgButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ContactEditCell.self, forCellReuseIdentifier: cellID)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        setUpHeaderView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
    }
    
    func setUpHeaderView() {
        msgButton.alignTextBelow(spacing: 4)
        callButton.alignTextBelow(spacing: 4)
        emailButton.alignTextBelow(spacing: 4)
        favButton.alignTextBelow(spacing: 4)
        
        favButton.addTarget(self, action: #selector(favButtonTapped(sender:)), for: .touchUpInside)
        
        headerImageView.layer.cornerRadius = headerImageView.frame.width/2
        headerImageView.layer.masksToBounds = true
        if let profileImage = contactDetails.profilePic {
            if profileImage.contains("missing.png") {
                headerImageView.loadImage(urlString: "http://gojek-contacts-app.herokuapp.com/images/missing.png")
            }
            else {
                headerImageView.loadImage(urlString: profileImage)
            }
        }
        if let fav = contactDetails.favorite {
            if fav {
                favButton.isSelected = true
                favButton.setImage(#imageLiteral(resourceName: "favourite_button_selected"), for: .selected)
            }
            else {
                favButton.isSelected = false
                favButton.setImage(#imageLiteral(resourceName: "favourite_button"), for: .normal)
            }
        }
        userFullNameLabel.text = "\(contactDetails.firstName ?? "") \(contactDetails.lastName ?? "")"

    }
    @objc func favButtonTapped(sender: UIButton) {
        if sender.isSelected {
            sender.setImage(#imageLiteral(resourceName: "favourite_button_selected"), for: .selected)
        }
        else {
            favButton.setImage(#imageLiteral(resourceName: "favourite_button"), for: .normal)
        }
        sender.isSelected = !sender.isSelected
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        print(editing)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.isEditing {
            return 4
        }
        else {
            return 2
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactEditCell", for: indexPath)
        as! ContactEditCell
        
        return cell
    }

    

}
