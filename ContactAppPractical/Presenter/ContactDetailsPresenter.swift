//
//  ContactDetailsPresenter.swift
//  ContactAppPractical
//
//  Created by Muvi on 18/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

protocol ContactDetailsDelegate: ContactCommonDelegate {
    func setContactWithID(user: ContactDetails)
    func updateAnyContact()
}

class ContactDetailsPresenter {
    
    private let contactService: ContactService
    weak private var cdDelegate: ContactDetailsDelegate?
    
    init(contactService: ContactService, cdDelegate: ContactDetailsDelegate) {
        self.contactService = contactService
        self.cdDelegate = cdDelegate
    }
    
    func performFetch(url: String, _ completionHandler: (() -> Void)?) {
        self.cdDelegate?.startLoading()
        contactService.fetchContact(urlString: url) { [weak self] (result) in
            defer { completionHandler?() }
            switch result {
            case .ok(let response):
                self?.cdDelegate?.finishLoading()
                let user = ContactDetails(json: response.dictionaryValue)
                self?.cdDelegate?.setContactWithID(user: user)
            case .error(let error):
                self?.cdDelegate?.showAlert(message: "", error: error)
            }
        }
    }
    func updateContact(urlString: String, body: [String: Any], _ completionHandler: (() -> Void)?) {
        self.cdDelegate?.startLoading()
        contactService.updateContact(urlString: urlString, body: body) { [weak self] (result) in
            defer { completionHandler?() }
            switch result {
            case .ok(_):
                self?.cdDelegate?.finishLoading()
                self?.cdDelegate?.updateAnyContact()
                self?.cdDelegate?.showAlert(message: "Contact updated successfully", error: nil)
            case .error(let error):
                self?.cdDelegate?.showAlert(message: "", error: error)
            }
        }
    }
}
