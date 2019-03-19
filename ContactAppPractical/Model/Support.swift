//
//  Support.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case ok(T)
    case error(E)
}

enum FetchError: Error {
    case load(Error)
    case noData
    case deserialization(Error)
}

enum ErrorsInContact: Error {
    case allFieldsAreEmpty
    case firstNameIsEmpty
    case lastNameIsEmpty
}

extension ErrorsInContact: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .allFieldsAreEmpty:
            return "All fields are empty!"
        case .firstNameIsEmpty:
            return "First name is empty!"
        case .lastNameIsEmpty:
            return "Last name is empty!"
        }
    }
}

extension FetchError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .load(_):
            return NSLocalizedString("fetchError.load", comment: "")
        case .deserialization(_):
            return NSLocalizedString("fetchError.deserialization", comment: "")
        case .noData:
            return NSLocalizedString("fetchError.noData", comment: "")
        }
    }
}

func handleFetchResponse<T: Decodable>(data: Data?, networkError: Error?) -> Result<T, FetchError> {
    if let networkError = networkError {
        return .error(FetchError.load(networkError))
    }
    
    guard let data = data else {
        return .error(FetchError.noData)
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
        let response = try decoder.decode(T.self, from: data)
        return .ok(response)
    } catch {
        return .error(FetchError.deserialization(error))
    }
}


struct JSONStringEncoder {
    /**
     Encodes a dictionary into a JSON string.
     - parameter dictionary: Dictionary to use to encode JSON string.
     - returns: A JSON string. `nil`, when encoding failed.
     */
    func encode(_ dictionary: [String: Any]) -> (jsonString: String?, jsonData: Data?) {
        guard JSONSerialization.isValidJSONObject(dictionary) else {
            assertionFailure("Invalid json object received.")
            return (nil, nil)
        }
        
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        let jsonData: Data
        
        dictionary.forEach { (arg) in
            jsonObject.setValue(arg.value, forKey: arg.key)
        }
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        } catch {
            assertionFailure("JSON data creation failed with error: \(error).")
            return (nil, nil)
        }
        
        guard let jsonString = String.init(data: jsonData, encoding: String.Encoding.utf8) else {
            assertionFailure("JSON string creation failed.")
            return (nil, nil)
        }
        
        print("JSON string: \(jsonString)")
        return (jsonString, jsonData)
    }
    
}

