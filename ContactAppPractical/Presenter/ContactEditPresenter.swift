//
//  ContactEditPresenter.swift
//  ContactAppPractical
//
//  Created by Muvi on 18/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation


protocol ContactEditDelegate: ContactCommonDelegate {
    func createNewContact(response: ContactDetails)
    func updateAnyContact()
}

class ContactEditPresenter {
    
    private let contactService: ContactService
    weak private var ceDelegate: ContactEditDelegate?
    
    init(contactService: ContactService, ceDelegate: ContactEditDelegate) {
        self.contactService = contactService
        self.ceDelegate = ceDelegate
    }
    
    func saveContact(body: [String: Any], _ completionHandler: (() -> Void)?) {
        self.ceDelegate?.startLoading()
        contactService.createNewContact(body: body) { [weak self] (result) in
            defer { completionHandler?() }
            switch result {
            case .ok(let response):
                print(response)
                self?.ceDelegate?.finishLoading()
                let user = ContactDetails(json: response.dictionaryValue)
                self?.ceDelegate?.createNewContact(response: user)
                self?.ceDelegate?.showAlert(message: "Contact updated successfully", error: nil)
            case .error(let error):
                self?.ceDelegate?.showAlert(message: "", error: error)
            }
        }
    }
    
    func updateContact(urlString: String, body: [String: Any], _ completionHandler: (() -> Void)?) {
        self.ceDelegate?.startLoading()
        contactService.updateContact(urlString: urlString, body: body) { [weak self] (result) in
            defer { completionHandler?() }
            switch result {
            case .ok(let response):
                print(response)
                self?.ceDelegate?.finishLoading()
                self?.ceDelegate?.updateAnyContact()
                self?.ceDelegate?.showAlert(message: "Contact updated successfully", error: nil)
            case .error(let error):
                self?.ceDelegate?.showAlert(message: "", error: error)
            }
        }
    }
}
