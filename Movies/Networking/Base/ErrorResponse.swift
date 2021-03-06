//
//  RequestError.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

enum ErrorResponse: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
