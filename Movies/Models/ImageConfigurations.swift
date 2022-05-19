//
//  Image.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 19.05.2022.
//

import Foundation

struct ImageConfigurations: Codable {
    let id: Int
    let backdrops: [ImageParameters]
    let posters: [ImageParameters]
    
    struct ImageParameters: Codable {
        let aspectRatio: Double
        let filePath: String
        let height: Int
        let iso639: String?
        let voteAverage: Int
        let voteCount: Int
        let width: Int
        
        enum CodingKeys: String, CodingKey {
            case height
            case width
            case aspectRatio = "aspect_ratio"
            case filePath = "file_path"
            case iso639 = "iso_639_1"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdrops
        case posters
    }
}
