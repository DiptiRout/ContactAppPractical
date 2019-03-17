//
//  ContactView.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

protocol ContactView: class {
    
    func startLoading()
    func finishLoading()
    func setContactList(users: [ContactList])
    func setContactListWithID(user: ContactDetails)
    func showAlertWithError(error: Error)
    
}
