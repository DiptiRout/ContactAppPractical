//
//  ContactService.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

class ContactService {
    
    typealias FetchResult = Result<[ContactList], FetchError>
    
    func fetchContactList(handler: @escaping ((FetchResult) -> Void)) {
        let url = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts.json")!
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
