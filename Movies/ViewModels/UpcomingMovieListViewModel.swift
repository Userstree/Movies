//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 25.05.2022.
//

import UIKit

protocol UpcomingMovieListViewModel: AnyObject {
    var movies: [Movie] { set get }

    var onFetchMovieSucceed: SuccessCallback? { set get }
    var onFetchMovieFailure: FailureCallback? { set get }

    func fetchData()
}

final class DefaultUpcomingMovieListViewModel {
    
    var movies: [Movie] = []
    
    var onFetchMovieSucceed: SuccessCallback?
    
    var onFetchMovieFailure: FailureCallback?
    
    private let service: MovieServiceable
    
    init(service: MovieServiceable) {
        self.service = service
    }
}

extension DefaultUpcomingMovieListViewModel: UpcomingMovieListViewModel {
    
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
