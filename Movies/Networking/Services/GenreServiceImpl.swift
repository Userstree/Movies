//
//  Service.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

class GenreServiceImpl: BaseRepository, GenreService {
    init() {
        super.init(basePath: "")
    }

    func getGenresList() async -> Result<GenresList, ErrorResponse>  {
        await get("genre/movie/list")
    }

}