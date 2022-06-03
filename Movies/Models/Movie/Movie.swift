//
//  Movie.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 17.05.2022.
//

import UIKit

struct Movie: Codable {

    var ratingLabelColor: Rating {
        if rating <= 4.0 {
            return .bad
        } else if rating > 4.0 && rating <= 7.0 {
            return .normal
        } else {
            return .good
        }
    }
    var genres: [String]?

    let genreIDs: [Int]?
    let id: Int
    let overview: String
    let posterPath: String
    let title: String
    let rating: Double
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case overview
        case id
        case title
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
        case rating = "vote_average"
        case releaseDate = "release_date"
    }
}