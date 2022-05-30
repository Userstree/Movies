//
//  PersonEndpoint.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 31.05.2022.
//

import UIKit

enum PersonEndpoint {
    case person
}

extension PersonEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .person:
            return "person"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .person:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .person:
            return [
                "Content-Type" : "application/json;charset=utf-8"
            ]
        }
    }
    
    var queryItems: [String : String] {
        let accessToken = "7a9ff9d95f6e5dc76e22f1989c7255d6"
        return [
            "api_key" : accessToken
        ]
    }
}
