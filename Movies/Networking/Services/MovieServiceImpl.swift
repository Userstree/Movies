//
//  Service.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

class MovieServiceImpl: BaseRepository, MovieService {
    init() {
        super.init(basePath: "movie/")
    }

    func getNowPlayingMovies() async -> Result<MoviesResponse, ErrorResponse> {
        await get("now_playing")
    }
    func getUpcomingMovies() async -> Result<MoviesResponse, ErrorResponse>  {
        await get("upcoming")
    }
    func getTopRatedMovies() async -> Result<MoviesResponse, ErrorResponse>  {
        await get("top_rated")
    }
    func getPopularMovies() async -> Result<MoviesResponse, ErrorResponse>  {
        await get("popular")
    }
}