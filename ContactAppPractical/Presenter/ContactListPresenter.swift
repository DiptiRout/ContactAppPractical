//
//  ContactListPresenter.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation
import UIKit

protocol ContactListDelegate: ContactCommonDelegate {
    func presentCreateScreen()
    func setContactList(users: [ContactList])
}

class ContactListPresenter {
    
    private let contactService: ContactService
    weak private var cvDelegate: ContactListDelegate?
    
    init(contactService: ContactService, cvDelegate: ContactListDelegate) {
        self.contactService = contactService
        self.cvDelegate = cvDelegate
    }
    
    func detachView() {
        cvDelegate = nil
    }
    
    func createContact() {
        cvDelegate?.presentCreateScreen()
    }
    
    func performFetch(url: String, _ completionHandler: (() -> Void)?) {
        self.cvDelegate?.startLoading()
        contactService.fetchContact(urlString: url) { [weak self] (result) in
            defer { completionHandler?() }
            switch result {
            case .ok(let response):
                self?.cvDelegate?.finishLoading()
                var users = [ContactList]()
                for user in response.arrayValue {
                    users.append(ContactList(json: user))
                }
                self?.cvDelegate?.setContactList(users: users)
            case .error(let error):
                self?.cvDelegate?.showAlert(message: "", error: error)
            }
        }
    }
    
    
    
    
}
