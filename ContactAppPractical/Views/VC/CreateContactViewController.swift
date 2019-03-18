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
    var isPlaceHolder = true
    var bodyData = [String: Any]()

    var favStatus = false
    
    fileprivate var contactPresenter: ContactEditPresenter?

    @IBOutlet weak var profileImageView: CachedImageView!
    
    var isCreate = true

    override func viewDidLoad() {
        super.viewDidLoad()
        contactPresenter = ContactEditPresenter(contactService: ContactService(), ceDelegate: self)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveContact))
        setUpData()
        
       
    }
    
    func setUpData() {
        self.hideKeyboardWhenTappedAround()
        isPlaceHolder = (contactDetails != nil) ? false : true
        editOptions.append(ContactEditOption(fieldLabel: "First Name", fieldEditText: contactDetails?.firstName ?? "First Name", isPlaceHolder: isPlaceHolder))
        editOptions.append(ContactEditOption(fieldLabel: "Last Name", fieldEditText: contactDetails?.lastName ?? "Last Name", isPlaceHolder: isPlaceHolder))
        editOptions.append(ContactEditOption(fieldLabel: "mobile", fieldEditText: contactDetails?.phoneNumber ?? "mobile", isPlaceHolder: isPlaceHolder))
        editOptions.append(ContactEditOption(fieldLabel: "email", fieldEditText: contactDetails?.email ?? "email", isPlaceHolder: isPlaceHolder))
        favStatus = contactDetails?.favorite ?? false
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 2
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
        if isPlaceHolder {
            bodyData["favorite"] = favStatus
            contactPresenter?.saveContact(body: bodyData) {
                self.navigationController?.popViewController(animated: true)
            }

        }
        else {
            contactPresenter?.updateContact(id: contactDetails?.id ?? 0, body: bodyData) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
            as! ContactEditCell
        cell.editOptions = editOptions[indexPath.row]
        cell.fieldEditText.delegate = self
        return cell
    }
}

extension CreateContactViewController: ContactEditDelegate {
    func createNewContact() {
        print("Create")
    }
    
    func updateAnyContact() {
        print("Update")
    }
    
    func startLoading() {
        print("start loading")
    }
    
    func finishLoading() {
        print("stop loading")
    }
    
    func showAlertWithError(error: Error) {
        print("show alert")
    }
    
    func getRootView() -> UIView {
        return self.view
    }
    

}

// MARK: - UITextFieldDelegate

extension CreateContactViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            setFieldData(textField: textField, text: updatedText)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setFieldData(textField: UITextField, text: String) {
        if textField.accessibilityIdentifier == "First Name" {
            bodyData["first_name"] = text
        }
        else if textField.accessibilityIdentifier == "Last Name" {
            bodyData["last_name"] = text
        }
        else if textField.accessibilityIdentifier == "mobile" {
            bodyData["phone_number"] = text
        }
        else if textField.accessibilityIdentifier == "email" {
            bodyData["email"] = text
        }
        print(bodyData)
    }
}
