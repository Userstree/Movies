//
//  Service.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

protocol MovieServiceable {
    func getNowPlayingMovies() async -> Result<NowPlaying, RequestError>
    func getUpcomingMovies() async -> Result<Upcoming, RequestError>
    func getMovieImageParameters(by id: Int) async -> Result<ImageConfigurations, RequestError>
    func fetchMovieImage() async -> Result<Data, RequestError>
}

struct MovieService: HTTPClient, MovieServiceable {
    
    func getNowPlayingMovies() async -> Result<NowPlaying, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.nowPlaying, responseModel: NowPlaying.self)
    }
    
    func getUpcomingMovies() async -> Result<Upcoming, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.upcoming, responseModel: Upcoming.self)
    }
    
    func getMovieImageParameters(by id: Int) async -> Result<ImageConfigurations, RequestError>{
        return await sendRequest(endpoint: MovieImageParametersEndpoint.image(id: id), responseModel: ImageConfigurations.self)
    }
    
    func fetchMovieImage() async -> Result<Data, RequestError> {
        return await sendRequest(endpoint: MovieImageEndpoint.w500, responseModel: Data.self)
    }
}


