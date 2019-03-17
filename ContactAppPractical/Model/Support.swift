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
