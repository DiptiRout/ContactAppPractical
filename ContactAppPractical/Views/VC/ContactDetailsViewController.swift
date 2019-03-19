//
//  ContactDetailsViewController.swift
//  ContactAppPractical
//
//  Created by Muvi on 17/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UITableViewController {
    
    let cellID = "ContactDetailsCell"
    var editOptions = [ContactEditOption]()
    var contactDetails: ContactDetails!
    var selectedContact: ContactList?
    fileprivate var contactPresenter: ContactDetailsPresenter?


    @IBOutlet weak var headerImageView: CachedImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var msgButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        setupNavBar()
        contactPresenter = ContactDetailsPresenter(contactService: ContactService(), cdDelegate: self)
        msgButton.set(image: #imageLiteral(resourceName: "message_button"), title: "message", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
        callButton.set(image: #imageLiteral(resourceName: "call_button"), title: "call", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
        emailButton.set(image: #imageLiteral(resourceName: "email_button"), title: "email", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
        favButton.set(image: #imageLiteral(resourceName: "favourite_button"), title: "favourite", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
        favButton.set(image: #imageLiteral(resourceName: "favourite_button_selected"), title: "favourite", titlePosition: .bottom, additionalSpacing: 0, state: .selected)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        contactPresenter?.performFetchWithID(id: selectedContact?.id ?? 0) {
            self.setUpHeaderView()
            self.tableView.reloadData()
        }

    }
    
    @objc func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
    @objc func openEditPage(_ sender: UIBarButtonItem) {
        let detailsVC = CreateContactViewController.instantiate(storyboardName: .main) as! CreateContactViewController
        detailsVC.contactDetails = contactDetails
        self.present(UINavigationController(rootViewController: detailsVC), animated: false, completion: nil)
    }
    func setupNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(openEditPage(_:)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backAction(_:)))
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3137254902, green: 0.8901960784, blue: 0.7607843137, alpha: 1)
        self.navigationItem.rightBarButtonItem?.accessibilityLabel = "EDIT"
    }
    func setUpHeaderView() {
        favButton.addTarget(self, action: #selector(favButtonTapped(sender:)), for: .touchUpInside)
        headerImageView.layer.cornerRadius = headerImageView.frame.width/2
        headerImageView.layer.masksToBounds = true
        headerImageView.layer.borderColor = UIColor.white.cgColor
        headerImageView.layer.borderWidth = 2
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
        
        let favStatus = sender.isSelected
        let bodyData = ["favorite" : favStatus]
        contactPresenter?.updateContact(id: contactDetails?.id ?? 0, body: bodyData) {
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ContactDetailsCell
        cell.editOptions = editOptions[indexPath.row]
        return cell
    }

}

extension ContactDetailsViewController: ContactDetailsDelegate {
    func showAlertWithMSG(message: String) {
        
    }
    
    func updateAnyContact() {
        print("Update")
    }
    
    func getRootView() -> UIView {
        return self.view
    }    
    func startLoading() {
    }
    
    func finishLoading() {
    }
    func setContactListWithID(user: ContactDetails) {
        contactDetails = user
        editOptions.removeAll()
        editOptions.append(ContactEditOption(fieldLabel: "mobile", fieldEditText: user.phoneNumber ?? "", isPlaceHolder: false))
        editOptions.append(ContactEditOption(fieldLabel: "email", fieldEditText: user.email ?? "", isPlaceHolder: false))
        
    }    
    func showAlertWithError(error: Error) {
    }
    
    
}
