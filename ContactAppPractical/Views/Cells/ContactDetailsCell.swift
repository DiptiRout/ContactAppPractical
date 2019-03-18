//
//  ContactDetailsCell.swift
//  ContactAppPractical
//
//  Created by Muvi on 18/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit

class ContactDetailsCell: UITableViewCell {

    @IBOutlet weak var fieldEditText: UILabel!
    @IBOutlet weak var fieldLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var editOptions: ContactEditOption? {
        didSet {
            if let editOptions = editOptions {
                fieldLabel.text = editOptions.fieldLabel
                fieldEditText.text = editOptions.fieldEditText
                fieldEditText.accessibilityIdentifier = fieldLabel.text
            }
        }
    }
}
