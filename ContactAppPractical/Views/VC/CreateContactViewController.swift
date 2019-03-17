//
//  CreateContactViewController.swift
//  ContactAppPractical
//
//  Created by Muvi on 17/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit

class CreateContactViewController: UITableViewController {

    let cellID = "ContactEditCell"
    var editOptions = [ContactEditOption]()
    var contactDetails: ContactDetails?
    
    @IBOutlet weak var profileImageView: CachedImageView!
    
    var isCreate = true

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveContact))
        setUpData()
        
       
    }
    
    func setUpData() {
        self.hideKeyboardWhenTappedAround()

        editOptions.append(ContactEditOption(fieldLabel: "First Name", fieldEditText: contactDetails?.firstName ?? "First Name"))
        editOptions.append(ContactEditOption(fieldLabel: "Last Name", fieldEditText: contactDetails?.lastName ?? "Last Name"))
        editOptions.append(ContactEditOption(fieldLabel: "mobile", fieldEditText: contactDetails?.phoneNumber ?? "mobile"))
        editOptions.append(ContactEditOption(fieldLabel: "email", fieldEditText: contactDetails?.email ?? "email"))
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.masksToBounds = true
        if let profileImage = contactDetails?.profilePic {
            if profileImage.contains("missing.png") {
                profileImageView.loadImage(urlString: "http://gojek-contacts-app.herokuapp.com/images/missing.png")
            }
            else {
                profileImageView.loadImage(urlString: profileImage)
            }
        }
    }
    
    @objc func saveContact() {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editOptions.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
            as! ContactEditCell
        cell.editOptions = editOptions[indexPath.row]
        cell.isCreate = isCreate
        return cell
    }
}
