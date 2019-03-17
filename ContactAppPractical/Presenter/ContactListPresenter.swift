//
//  ContactListPresenter.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation
import UIKit

class ContactListPresenter {
    
    private let contactService: ContactService
    weak private var contactView: ContactView?
    
    init(contactService: ContactService) {
        self.contactService = contactService
    }
    
    func attachView(view: ContactView) {
        contactView = view
    }
    
    func detachView() {
        contactView = nil
    }
    
    func createContact() {
    }
    
    func performFetch(_ completionHandler: (() -> Void)?) {
        self.contactView?.startLoading()
        contactService.fetchContactList { [weak self] (result) in
            switch result {
            case .ok(let response):
                self?.contactView?.finishLoading()
                self?.contactView?.setContactList(users: response)
            case .error(let error):
                self?.contactView?.showAlertWithError(error: error)
            }
        }
    }
    
    func performFetchWithID(id: Int, _ completionHandler: (() -> Void)?) {
        self.contactView?.startLoading()
        contactService.fetchContactListWithID(id: id) { [weak self] (result) in
            defer { completionHandler?() }
            switch result {
            case .ok(let response):
                self?.contactView?.finishLoading()
                self?.contactView?.setContactListWithID(user: response)
            case .error(let error):
                self?.contactView?.showAlertWithError(error: error)
            }
        }
    }
}
