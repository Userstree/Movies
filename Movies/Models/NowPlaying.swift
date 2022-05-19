//
//  NowPlaying.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 19.05.2022.
//

import Foundation

struct NowPlaying: Codable {
    var totalResults: Int
    var totalPages: Int
    var dates: [String : String]
    var results: [Movie]
    var page: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case dates
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
