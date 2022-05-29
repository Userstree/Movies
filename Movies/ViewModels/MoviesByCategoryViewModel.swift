//
//  MoviesByCategoryViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 30.05.2022.
//

import Foundation

public protocol Model: Codable {
    static var decoder: JSONDecoder { get }
}

public extension Model {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

struct ResultCall<T: Model>: Model {
    let page: Int
    let totalPages: Int
    let results: [T]
    
    static var decoder: JSONDecoder { T.decoder }
}

struct newMovieModel: Model {
    let totalResults: Int
    let totalPages: Int
    let dates: [String : String]
    let movies: [Movie]
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case dates
        case movies = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
//    static var decoder: JSONDecoder { T.decoder }
}

final class MoviesByCategoryViewModel {
    
}
