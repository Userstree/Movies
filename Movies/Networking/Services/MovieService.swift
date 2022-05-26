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
    func fetchMovieImage(path: String) async -> Result<UIImage, ErrorResponse>
}

struct MovieService: DataRequest, MovieServiceable, ImageRequest {    
    
    func getNowPlayingMovies() async -> Result<NowPlaying, ErrorResponse> {
        return await sendDataRequest(endpoint: MoviesEndpoint.nowPlaying, responseModel: NowPlaying.self)
    }
    
    func getUpcomingMovies() async -> Result<Upcoming, ErrorResponse> {
        return await sendDataRequest(endpoint: MoviesEndpoint.upcoming, responseModel: Upcoming.self)
    }
    
    func fetchMovieImage(path: String) async -> Result<UIImage, ErrorResponse> {
        return await sendImageRequest(endpoint: MovieImageEndpoint.w500, path: path)
    }
}


