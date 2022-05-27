//
//  Service.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation
import UIKit

protocol MovieServiceable {
    func getNowPlayingMovies() async -> Result<NowPlaying, ErrorResponse>
    func getUpcomingMovies() async -> Result<Upcoming, ErrorResponse>
}

struct MovieService: MovieInfoRequest, MovieServiceable {
    
    func getNowPlayingMovies() async -> Result<NowPlaying, ErrorResponse> {
        return await sendMovieInfoRequest(endpoint: MoviesListEndpoint.nowPlaying, responseModel: NowPlaying.self)
    }
    
    func getUpcomingMovies() async -> Result<Upcoming, ErrorResponse> {
        return await sendMovieInfoRequest(endpoint: MoviesListEndpoint.upcoming, responseModel: Upcoming.self)
    }
}


