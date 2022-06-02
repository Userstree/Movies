//
//  Genre.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 01.06.2022.
//

import Foundation

struct GenresList: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
