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
    
    func performFetch(_ completionHandler: (() -> Void)?) {
        self.cvDelegate?.startLoading()
        contactService.fetchContactList { [weak self] (result) in
            switch result {
            case .ok(let response):
                self?.cvDelegate?.finishLoading()
                self?.cvDelegate?.setContactList(users: response)
            case .error(let error):
                self?.cvDelegate?.showAlertWithError(error: error)
            }
        }
    }
    
    
    
    
}
