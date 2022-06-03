//
//  MoviesEndPoint.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

enum MoviesListEndpoint: String {
    case upcoming = "Soon at the cinema"
    case nowPlaying = "Today at the cinema"
    case topRated = "Top Rated"
    case popular = "Popular movies"
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
        case .topRated:
            return "movie/top_rated"
        case .popular:
            return "movie/popular"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .upcoming, .nowPlaying, .topRated, .popular:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .upcoming, .nowPlaying, .topRated, .popular:
            return [
                "Content-Type" : "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .upcoming, .nowPlaying, .topRated, .popular:
            return nil
        }
    }
}
