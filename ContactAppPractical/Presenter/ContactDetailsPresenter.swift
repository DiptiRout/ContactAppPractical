//
//  ContactDetailsPresenter.swift
//  ContactAppPractical
//
//  Created by Muvi on 18/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

protocol ContactDetailsDelegate: ContactCommonDelegate {
    func setContactListWithID(user: ContactDetails)
    func updateAnyContact()
}

class ContactDetailsPresenter {
    
    private let contactService: ContactService
    weak private var cdDelegate: ContactDetailsDelegate?
    
    init(contactService: ContactService, cdDelegate: ContactDetailsDelegate) {
        self.contactService = contactService
        self.cdDelegate = cdDelegate
    }
    
    func performFetchWithID(id: Int, _ completionHandler: (() -> Void)?) {
        self.cdDelegate?.startLoading()
        contactService.fetchContactListWithID(id: id) { [weak self] (result) in
            defer { completionHandler?() }
            switch result {
            case .ok(let response):
                self?.cdDelegate?.finishLoading()
                self?.cdDelegate?.setContactListWithID(user: response)
            case .error(let error):
                self?.cdDelegate?.showAlertWithError(error: error)
            }
        }
    }
    func updateContact(id: Int, body: [String: Any], _ completionHandler: (() -> Void)?) {
        self.cdDelegate?.startLoading()
        contactService.updateContact(id: id, body: body) { [weak self] (result) in
            defer { completionHandler?() }
            switch result {
            case .ok(let response):
                print(response)
                self?.cdDelegate?.finishLoading()
                self?.cdDelegate?.updateAnyContact()
            case .error(let error):
                self?.cdDelegate?.showAlertWithError(error: error)
            }
        }
    }
}
