//
//  ContactService.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

class ContactService {
    
    typealias ContactResult = Result<JSON, FetchError>

    typealias FetchContactDetails = Result<ContactDetails, FetchError>
    typealias SaveContactReport = Result<ContactDetails, FetchError>


    let baseURL = "http://gojek-contacts-app.herokuapp.com/contacts.json"
    
    func fetchContact(urlString: String, handler: @escaping ((ContactResult) -> Void)) {
        let url = URL(string: urlString)!
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: { (data, _, networkError) in
            DispatchQueue.main.async {
                handler(handleFetchResponse(data: data, networkError: networkError))
            }
        })
        task.resume()
    }
    
    func createNewContact(body: [String: Any], handler: @escaping ((ContactResult) -> Void)) {
        let url = URL(string: baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json = JSONStringEncoder().encode(body)
        if let jsonData = json.jsonData {
            request.httpBody = jsonData
        }
        else {
            print("Missing http body")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, networkError) in
            DispatchQueue.main.async {
                handler(handleFetchResponse(data: data, networkError: networkError))
            }
        })
        task.resume()
    }
    
    func updateContact(urlString: String, body: [String: Any], handler: @escaping ((ContactResult) -> Void)) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let json = JSONStringEncoder().encode(body)
        if let jsonData = json.jsonData {
            request.httpBody = jsonData
        }
        else {
            print("Missing http body")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, networkError) in
            DispatchQueue.main.async {
               handler(handleFetchResponse(data: data, networkError: networkError))
            }
        })
        task.resume()
    }
    
   
}
