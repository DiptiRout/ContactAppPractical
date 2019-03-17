//
//  ContactListCell.swift
//  ContactAppPractical
//
//  Created by Muvi on 17/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit


class ContactListCell: UITableViewCell {
    
    let thumImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage().image(#imageLiteral(resourceName: "placeholder_photo"), withSize: CGSize(width: 40, height: 40))
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let favImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpView() {
        contentView.addSubview(thumImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(favImageView)
        thumImageView.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: nil, topConstant: 12, leftConstant: 16, bottomConstant: 12, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        favImageView.anchor(contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 32, widthConstant: 30, heightConstant: 30)
        nameLabel.anchor(contentView.topAnchor, left: thumImageView.rightAnchor, bottom: nil, right: favImageView.leftAnchor, topConstant: 24, leftConstant: 16, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }

    var contact: ContactList? {
        didSet {
            if let contact = contact {
                nameLabel.text = contact.firstName
                if contact.favorite == true {
                    favImageView.image = #imageLiteral(resourceName: "home_favourite")
                }
                else {
                    favImageView.image = UIImage()
                }
                if let thumb = contact.profilePic {
                    if thumb.contains("missing.png") {
                        thumImageView.loadImage(urlString: "http://gojek-contacts-app.herokuapp.com/images/missing.png")
                    }
                    else {
                        thumImageView.loadImage(urlString: thumb)
                    }
                }
            }
        }
    }
}
