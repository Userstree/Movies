//
//  Upcoming.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 19.05.2022.
//

import Foundation

struct Upcoming: Codable {
    let totalResults: Int
    let totalPages: Int
    let dates: [String : String]
    let results: [Movie]
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case dates
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
