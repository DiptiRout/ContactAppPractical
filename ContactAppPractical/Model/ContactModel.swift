//
//  ContactModel.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

struct ContactList: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let profilePic: String?
    let favorite: Bool?
    let url: String?
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.profilePic = json["profile_pic"].stringValue
        self.favorite = json["favorite"].boolValue
        self.url = json["url"].stringValue
    }
    
}

struct ContactDetails: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let email: String?
    let phoneNumber: String?
    let profilePic: String?
    let favorite: Bool?
    let createdAt: String?
    let updatedAt: String?
    
    init(json: [String: JSON]) {
        self.id = json["id"]?.intValue
        self.firstName = json["first_name"]?.stringValue
        self.lastName = json["last_name"]?.stringValue
        self.email = json["email"]?.stringValue
        self.phoneNumber = json["phone_number"]?.stringValue
        self.profilePic = json["profile_pic"]?.stringValue
        self.favorite = json["favorite"]?.boolValue
        self.createdAt = json["created_at"]?.stringValue
        self.updatedAt = json["updated_at"]?.stringValue
    }
    
}

struct ContactEditOption: Codable {
    let fieldLabel: String?
    let fieldEditText: String?
    let isPlaceHolder: Bool?
    
    init(fieldLabel: String, fieldEditText: String, isPlaceHolder: Bool) {
        self.fieldLabel = fieldLabel
        self.fieldEditText = fieldEditText
        self.isPlaceHolder = isPlaceHolder
    }
}

struct SaveContact: Codable {
    let firstName: String?
    let lastName: String?
    let email: String?
    let phoneNumber: String?
    let favorite: Bool?
    init(firstName: String, lastName: String, email: String, phoneNumber: String, favorite: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.favorite = favorite
    }
}
