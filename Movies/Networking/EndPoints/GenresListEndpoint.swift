//
//  GenresListEndpoint.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 01.06.2022.
//

import Foundation

enum GenresListEndpoint {
    case genres
}

extension GenresListEndpoint: Endpoint {
    
    var queryItems: [String : String] {
        return ["api_key" : "7a9ff9d95f6e5dc76e22f1989c7255d6"]
    }
    
    var path: String {
        switch self {
        case .genres:
            return "genre/movie/list"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .genres:
            return .get
        }
    }
    
//    var header: [String: String]? {
//        switch self {
//        case .genres:
//            return [
//                "Content-Type" : "application/json;charset=utf-8"
//            ]
//        }
//    }
}
