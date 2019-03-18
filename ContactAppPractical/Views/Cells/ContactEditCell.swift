//
//  ContactEditCell.swift
//  ContactAppPractical
//
//  Created by Muvi on 17/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit

protocol ContactFieldDelegate: class {
    func getValueWithKey(key: String, value: Any)
}

class ContactEditCell: UITableViewCell {

    @IBOutlet weak var fieldEditText: UITextField!
    @IBOutlet weak var fieldLabel: UILabel!
    weak var keyDelegate: ContactFieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fieldEditText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    var editOptions: ContactEditOption? {
        didSet {
            if let editOptions = editOptions {
                if editOptions.isPlaceHolder! {
                    fieldLabel.text = editOptions.fieldLabel
                    fieldEditText.text = ""
                    fieldEditText.placeholder = editOptions.fieldEditText
                }
                else {
                    fieldLabel.text = editOptions.fieldLabel
                    fieldEditText.text = editOptions.fieldEditText
                }
               
                fieldEditText.accessibilityIdentifier = fieldLabel.text
                if fieldEditText.accessibilityIdentifier == "mobile" {
                    fieldEditText.keyboardType = .numberPad
                }
                else if fieldEditText.accessibilityIdentifier == "email" {
                    fieldEditText.keyboardType = .emailAddress
                }
                else {
                    fieldEditText.keyboardType = .default
                }
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        keyDelegate?.getValueWithKey(key: fieldLabel.text ?? "", value: textField.text ?? "")
    }

}
