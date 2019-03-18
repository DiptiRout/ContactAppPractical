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
