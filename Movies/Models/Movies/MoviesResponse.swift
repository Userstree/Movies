//
//  Upcoming.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 19.05.2022.
//

import Foundation

struct MoviesResponse: Codable {
    let totalResults: Int
    let totalPages: Int
    let movies: [Movie]
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
