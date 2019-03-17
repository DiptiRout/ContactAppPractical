//
//  ContactService.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

class ContactService {
    
    typealias FetchContacts = Result<[ContactList], FetchError>
    typealias FetchContactDetails = Result<ContactDetails, FetchError>

    let baseURL = "http://gojek-contacts-app.herokuapp.com"
    
    func fetchContactList(handler: @escaping ((FetchContacts) -> Void)) {
        let url = URL(string: "\(baseURL)/contacts.json")!
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: { (data, _, networkError) in
            DispatchQueue.main.async {
                handler(handleFetchResponse(data: data, networkError: networkError))
            }
        })
        
        task.resume()
    }
    
    func fetchContactListWithID(id: Int, handler: @escaping ((FetchContactDetails) -> Void)) {
        let url = URL(string: "\(baseURL)/contacts/\(id).json")!
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: { (data, _, networkError) in
            DispatchQueue.main.async {
                handler(handleFetchResponse(data: data, networkError: networkError))
            }
        })
        
        task.resume()
    }
    
    
    
}
