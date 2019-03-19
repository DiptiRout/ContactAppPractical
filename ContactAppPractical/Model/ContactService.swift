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
    typealias SaveContactReport = Result<ContactDetails, FetchError>


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
    
    func createNewContact(body: [String: Any], handler: @escaping ((SaveContactReport) -> Void)) {
        let url = URL(string: "\(baseURL)/contacts.json")!
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "POST"
        
        contactAPICall(body: body, request: requestUrl)

    }
    
    func updateContact(id: Int, body: [String: Any], handler: @escaping ((FetchContactDetails) -> Void)) {
        let url = URL(string: "\(baseURL)/contacts/\(id).json")!
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "PUT"
        
        contactAPICall(body: body, request: requestUrl)
    }
    
    func contactAPICall(body: [String: Any], request: URLRequest) {
        let json = JSONStringEncoder().encode(body)
        var request = request
        if let jsonData = json.jsonData {
            request.httpBody = jsonData
        }
        else {
            print("Missing http body")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, networkError) in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                //handler(handleFetchResponse(data: data, networkError: networkError))
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(JSONStringEncoder().encode(json).jsonString ?? "NAN")
                    
                } catch {
                    assertionFailure("JSON data creation failed with error: \(error).")
                }
            }
        })
        task.resume()
    }
    
}
