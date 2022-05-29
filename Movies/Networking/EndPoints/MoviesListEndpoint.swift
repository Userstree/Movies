//
//  MoviesEndPoint.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

enum MoviesListEndpoint {
    case upcoming
    case nowPlaying
    
}

extension MoviesListEndpoint: Endpoint {
    
    var queryItems: [String : String] {
        let accessToken = "7a9ff9d95f6e5dc76e22f1989c7255d6"
        return [
            "api_key" : accessToken
        ]
    }
    
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
        switch self {
        case .upcoming, .nowPlaying:
            return [
                "Content-Type" : "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .upcoming, .nowPlaying:
            return nil
        }
    }
}
