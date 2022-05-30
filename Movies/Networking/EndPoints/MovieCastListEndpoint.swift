//
//  CastEndpoint.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 28.05.2022.
//

import UIKit

enum MovieCastListEndpoint {
    case movie
}

extension MovieCastListEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .movie:
            return "movie/"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .movie:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .movie:
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
