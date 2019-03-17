//
//  ContactEditCell.swift
//  ContactAppPractical
//
//  Created by Muvi on 17/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit

class ContactEditCell: UITableViewCell {

    @IBOutlet weak var fieldEditText: UITextField!
    @IBOutlet weak var fieldLabel: UILabel!
    var isCreate = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fieldEditText.delegate = self
    }
    
    var editOptions: ContactEditOption? {
        didSet {
            if let editOptions = editOptions {
                if isCreate {
                    fieldLabel.text = editOptions.fieldLabel
                    fieldEditText.placeholder = editOptions.fieldEditText
                }
                else {
                    fieldLabel.text = editOptions.fieldLabel
                    fieldEditText.text = editOptions.fieldEditText
                }
                
            }
        }
    }
}

extension ContactEditCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if fieldLabel.text == "mobile" {
            textField.keyboardType = .numberPad
        }
        else if fieldLabel.text == "email" {
            textField.keyboardType = .emailAddress
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
