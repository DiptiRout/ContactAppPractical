//
//  ContactListTableViewController.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    
    let cellID = "ContactListCell"
    fileprivate var groupedContactList = [[ContactList]]()
    fileprivate var contactDetails: ContactDetails!
    fileprivate var contactEditOptions = [ContactEditOption]()

    fileprivate let contactPresenter = ContactListPresenter(contactService: ContactService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ContactListCell.self, forCellReuseIdentifier: cellID)
        contactPresenter.attachView(view: self)
        contactPresenter.performFetch {
            print("Data Fetched")
        }
    }
    @IBAction func createContact(_ sender: UIBarButtonItem) {
        contactPresenter.createContact()
    }
}


extension ContactListTableViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedContactList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedContactList[section].count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ContactListCell
        let contact = groupedContactList[indexPath.section][indexPath.row]
        cell.contact = contact
     
     return cell
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let secHeader = String((groupedContactList[section][0].firstName?.first)!)
        return secHeader

    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let secHeader = groupedContactList.map{
            $0[0].firstName?.first?.description
        }
        return secHeader as? [String]
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = groupedContactList[indexPath.section][indexPath.row]
        let detailsVC = ContactDetailsViewController.instantiate(storyboardName: .main) as! ContactDetailsViewController
        contactPresenter.performFetchWithID(id: contact.id ?? 0) {
            detailsVC.contactDetails = self.contactDetails
            detailsVC.editOptions = self.contactEditOptions
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension ContactListTableViewController: ContactView {
    func presentCreateScreen() {
        
        let detailsVC = CreateContactViewController.instantiate(storyboardName: .main) as! CreateContactViewController
        self.navigationController?.pushViewController(detailsVC, animated: true)

    }
    
    
    
    func startLoading() {
        
    }
    
    func finishLoading() {

    }
    
    func setContactList(users: [ContactList]) {
    
        let sortedContacts = users.sorted(by: { $0.firstName ?? "" < $1.firstName ?? ""}) // sort the Array first.
        let groupedContacts = sortedContacts.reduce([[ContactList]]()) {
            guard var last = $0.last else { return [[$1]] }
            var collection = $0
            if last.first!.firstName!.first == $1.firstName!.first {
                last += [$1]
                collection[collection.count - 1] = last
            } else {
                collection += [[$1]]
            }
            return collection
        }
        groupedContactList = groupedContacts
        tableView.reloadData()
    }
    
    func setContactListWithID(user: ContactDetails) {
        contactDetails = user
        contactEditOptions.removeAll()
        contactEditOptions.append(ContactEditOption(fieldLabel: "mobile", fieldEditText: user.phoneNumber ?? ""))
        contactEditOptions.append(ContactEditOption(fieldLabel: "email", fieldEditText: user.email ?? ""))
        
    }
    
    
    func showAlertWithError(error: Error) {
    }
    
    
}
