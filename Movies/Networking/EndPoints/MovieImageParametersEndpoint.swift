//
//  MoviesImagesEndpoint.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 19.05.2022.
//

import Foundation

enum MovieImageParametersEndpoint {
    case image(id: Int)
}

extension MovieImageParametersEndpoint: Endpoint {
    var path: String {
        switch self {
        case .image (let id):
            return "movie/\(id)/images"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .image(_):
            return .get
        }
    }
    
    var header: [String : String]? {
        let accessToken = "7a9ff9d95f6e5dc76e22f1989c7255d6"
        switch self {
        case .image(_):
            return [
                "Content-Type" : "application/json;charset=utf-8",
                "Authorization" : "Bearer \(accessToken)"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .image(_):
            return nil
        }
    }
}
