//
//  Service.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

protocol MovieServiceable {
    func getNowPlayingMovies() async -> Result<NowPlaying, ErrorResponse>
    func getUpcomingMovies() async -> Result<Upcoming, ErrorResponse>
//    func getMovieCast(by movieID: Int) async -> Result<CastList, ErrorResponse>
    func getGenresList() async -> Result<[Genre], ErrorResponse>
}

final class MovieService: GenresListRequest, MovieInfoRequest, MovieServiceable {
    
    func getNowPlayingMovies() async -> Result<NowPlaying, ErrorResponse> {
        return await sendMovieInfoRequest(endpoint: MoviesListEndpoint.nowPlaying, responseModel: NowPlaying.self)
    }
    
    func getUpcomingMovies() async -> Result<Upcoming, ErrorResponse> {
        return await sendMovieInfoRequest(endpoint: MoviesListEndpoint.upcoming, responseModel: Upcoming.self)
    }
    
//    func getMovieCast(by movieID: Int) async -> Result<CastList, ErrorResponse> {
//        return await sendMovieInfoRequest(endpoint: MovieCastListEndpoint.movie, forMovieWithID: movieID, responseModel: CastList.self)
//    }
    
    func getGenresList() async -> Result<[Genre], ErrorResponse> {
        return await sendGenresListRequest(endpoint: GenresListEndpoint.genres, responseModel: [Genre].self)
    }
}


