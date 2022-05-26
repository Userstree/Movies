//
//  MovieImageEndpoint.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 19.05.2022.
//

import Foundation

enum MovieImageEndpoint {
    case w500
    case original
}

extension MovieImageEndpoint: Endpoint {
    
    var queryItems: [String : String] {
        let accessToken = "7a9ff9d95f6e5dc76e22f1989c7255d6"
        return [
            "api_key" : accessToken
        ]
    }
    
    var baseURL: String {
        return "https://image.tmdb.org/t/p/"
    }
    
    var path: String {
        switch self {
        case .w500:
            return "w500"
        case .original:
            return "original"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .w500, .original:
            return .get
        }
    }
    
    var header: [String : String]? {
//        let accessToken = "7a9ff9d95f6e5dc76e22f1989c7255d6"
        switch self {
        case .w500, .original:
            return [
                "Content-Type" : "application/json;charset=utf-8",
//                "Authorization" : "Bearer \(accessToken)"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .w500, .original:
            return nil
        }
    }
}
