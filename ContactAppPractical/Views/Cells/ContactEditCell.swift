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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var editOptions: ContactEditOption? {
        didSet {
            if let editOptions = editOptions {
                fieldLabel.text = editOptions.fieldLabel
                fieldEditText.text = editOptions.fieldEditText
            }
        }
    }

}
