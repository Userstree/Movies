//
//  Movie.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 17.05.2022.
//

import UIKit

struct Movie: Codable {
    let backdropPath: String
    let genreIDs: [Int]?
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String
    let title: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case overview
        case popularity
        case id
        case title
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
        case rating = "vote_average"
    }
}

enum Rating {
    case lessThanFour
    case lessThanSeven
    case moreThanSeven
    
    var labelColor: UIColor {
        switch self {
        case .lessThanFour:
            return .orange
        case .lessThanSeven:
            return .yellow
        case .moreThanSeven:
            return .green
        }
    }
}

