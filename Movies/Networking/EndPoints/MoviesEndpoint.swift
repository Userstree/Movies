//
//  MoviesEndPoint.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

enum MoviesEndpoint {
    case upcoming
    case nowPlaying
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .upcoming:
            return "movie/upcoming"
        case .nowPlaying:
            return "movie/now_playing"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .upcoming, .nowPlaying:
            return .get
        }
    }
    
    var header: [String : String]? {
//        let accessToken = "7a9ff9d95f6e5dc76e22f1989c7255d6"
        switch self {
        case .upcoming, .nowPlaying:
            return [
//                "Authorization" : "Bearer \(accessToken)",
                "Content-Type" : "application/json;charset=utf-8",
//                "Accept": "application/json",
//                "api_key" : "\(accessToken)"
            ]
        }
    }
    
    
    var queryItems: [String : String] {
        let accessToken = "7a9ff9d95f6e5dc76e22f1989c7255d6"
        return [
            "api_key" : accessToken
        ]
    }
    
    var body: [String : String]? {
        switch self {
        case .upcoming, .nowPlaying:
            return nil
        }
    }
}
