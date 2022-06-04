//
//  Service.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import Foundation

protocol MovieService {
    func getNowPlayingMovies() async -> Result<MoviesResponse, ErrorResponse>
    func getUpcomingMovies() async -> Result<MoviesResponse, ErrorResponse>
    func getTopRatedMovies() async -> Result<MoviesResponse, ErrorResponse>
    func getPopularMovies() async -> Result<MoviesResponse, ErrorResponse>
}