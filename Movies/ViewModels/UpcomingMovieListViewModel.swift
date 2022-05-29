//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 25.05.2022.
//

import UIKit

protocol UpcomingMovieListViewModel: AnyObject {
    var movies: [Movie] { set get }

    var onFetchMovieSucceed: (() -> Void)? { set get }
    var onFetchMovieFailure: ((Error) -> Void)? { set get }

    func fetchData()
}

final class UpcomingMovieListDefaultViewModel: UpcomingMovieListViewModel {
    
    var movies: [Movie] = []
    
    var onFetchMovieSucceed: (() -> Void)?
    
    var onFetchMovieFailure: ((Error) -> Void)?
    
    private let service: MovieServiceable
    
    init(service: MovieServiceable) {
        self.service = service
    }
    
    func fetchData() {
        Task {
            let result = await service.getUpcomingMovies()            
            switch result {
            case .success(let upComing):
                DispatchQueue.main.async {
                    self.movies = upComing.movies
                    self.onFetchMovieSucceed?()
                }
            case .failure(let error):
                self.onFetchMovieFailure?(error)
            }
        }
    }
}
