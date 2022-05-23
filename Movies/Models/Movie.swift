//
//  Movie.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 17.05.2022.
//

import UIKit

//struct Movie {
//    var title: String?
//    var image: UIImage?
//}

struct Movie: Codable {
    let backdropPath: String
    let genreIDs: [Int]?
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String
    let title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case overview
        case popularity
        case id
        case title
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

enum Rating: Double{
    case green
    case orange
    case red
}

