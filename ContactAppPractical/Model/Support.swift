//
//  Support.swift
//  ContactAppPractical
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

enum Result<JSON, E: Error> {
    case ok(JSON)
    case error(E)
}

enum FetchError: Error {
    case load(Error)
    case noData
    case deserialization(Error)
    case allFieldsAreEmpty
    case firstNameIsEmpty
    case lastNameIsEmpty
    case invalidPhoneNumber(String)
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
        case .allFieldsAreEmpty:
            return "All fields are empty!"
        case .firstNameIsEmpty:
            return "First name is empty!"
        case .lastNameIsEmpty:
            return "Last name is empty!"
        case .invalidPhoneNumber(let msg):
            return msg
        }
    }
}

func handleFetchResponse(data: Data?, networkError: Error?) -> Result<JSON, FetchError> {
    if let networkError = networkError {
        return .error(FetchError.load(networkError))
    }
    
    guard let data = data else {
        return .error(FetchError.noData)
    }
    do {
        let json = try JSON(data: data)
        switch json.type {
        case .array:
            let key = json.arrayValue.first?.dictionaryValue.keys.first
            if key == "errors" {
                return .error(FetchError.firstNameIsEmpty)
            }
            else {
                return .ok(json)
            }
        case .dictionary:
            let key = json.dictionaryValue.keys.first
            if key == "errors" {
                let value = json["errors"][0].stringValue
                return .error(FetchError.invalidPhoneNumber(value))
            }
            else {
                return .ok(json)
            }
        default:
            return .ok(json)
        }
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

