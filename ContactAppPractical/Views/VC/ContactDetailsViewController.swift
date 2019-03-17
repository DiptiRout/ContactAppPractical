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
    var editOptions = [ContactEditOption]()
    var contactDetails: ContactDetails!
    var selectedContact: ContactList?
    fileprivate let contactPresenter = ContactListPresenter(contactService: ContactService())


    @IBOutlet weak var headerImageView: CachedImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var msgButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        contactPresenter.attachView(view: self)
        msgButton.alignTextBelow(spacing: 4)
        callButton.alignTextBelow(spacing: 4)
        emailButton.alignTextBelow(spacing: 4)
        favButton.alignTextBelow(spacing: 4)
        contactPresenter.performFetchWithID(id: selectedContact?.id ?? 0) {
            self.setUpHeaderView()
            self.tableView.reloadData()
        }
        
    }
    
    func setUpHeaderView() {
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
        //super.setEditing(editing, animated: animated)
        let detailsVC = CreateContactViewController.instantiate(storyboardName: .main) as! CreateContactViewController
        detailsVC.contactDetails = contactDetails
        self.navigationController?.pushViewController(detailsVC, animated: true)
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
        cell.isCreate = false
        cell.isUserInteractionEnabled = false
        return cell
    }

}

extension ContactDetailsViewController: ContactView {
    func startLoading() {
    }
    
    func finishLoading() {
    }
    
    func presentCreateScreen() {
    }
    func setContactList(users: [ContactList]) {
    }
    
    func setContactListWithID(user: ContactDetails) {
        contactDetails = user
        editOptions.removeAll()
        editOptions.append(ContactEditOption(fieldLabel: "mobile", fieldEditText: user.phoneNumber ?? ""))
        editOptions.append(ContactEditOption(fieldLabel: "email", fieldEditText: user.email ?? ""))
        
    }

    
    func showAlertWithError(error: Error) {
    }
    
    
}
