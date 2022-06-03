//
//  Service.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

protocol MovieServiceable {
    func getNowPlayingMovies() async -> Result<MoviesResponse, ErrorResponse>
    func getUpcomingMovies() async -> Result<MoviesResponse, ErrorResponse>
    func getTopRatedMovies() async -> Result<MoviesResponse, ErrorResponse>
    func getPopularMovies() async -> Result<MoviesResponse, ErrorResponse>
    func getGenresList() async -> Result<GenresList, ErrorResponse>
}

final class MovieService: GenresListRequest, MovieInfoRequest, MovieServiceable {
    init() {}

    func getNowPlayingMovies() async -> Result<MoviesResponse, ErrorResponse> {
        return await sendMovieInfoRequest(endpoint: MoviesListEndpoint.nowPlaying, responseModel: MoviesResponse.self)
    }
    
    func getUpcomingMovies() async -> Result<MoviesResponse, ErrorResponse> {
        return await sendMovieInfoRequest(endpoint: MoviesListEndpoint.upcoming, responseModel: MoviesResponse.self)
    }

    func getTopRatedMovies() async -> Result<MoviesResponse, ErrorResponse> {
        return await sendMovieInfoRequest(endpoint: MoviesListEndpoint.topRated, responseModel: MoviesResponse.self)
    }

    func getPopularMovies() async -> Result<MoviesResponse, ErrorResponse> {
        return await sendMovieInfoRequest(endpoint: MoviesListEndpoint.popular, responseModel: MoviesResponse.self)
    }
    
    func getGenresList() async -> Result<GenresList, ErrorResponse> {
        return await sendGenresListRequest(endpoint: GenresListEndpoint.genres, responseModel: GenresList.self)
    }
}


