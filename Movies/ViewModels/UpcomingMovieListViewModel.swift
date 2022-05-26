//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 25.05.2022.
//

import UIKit

protocol UpcomingMovieListViewModel: AnyObject {
//    var movieImage: UIImage? { get }
    var movies: [Movie] { set get }

    var onFetchMovieSucceed: (() -> Void)? { set get }
    var onFetchMovieFailure: ((Error) -> Void)? { set get }

    func fetchData()
    func fetchImage(posterPath: String)
}

final class UpcomingMovieListDefaultViewModel: UpcomingMovieListViewModel {
    
    var movies: [Movie] = []
    
    var movieImage: UIImage?
    
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
                self.movies = upComing.movies
//                self.fetchImage(posterPath: upComing.movies[0].posterPath)
                self.onFetchMovieSucceed?()
            case .failure(let error):
                self.onFetchMovieFailure?(error)
            }
        }
    }

    func fetchImage(posterPath: String) {
        Task {
            let result = await ImageService.shared.fetchMovieImage(path: posterPath)
            switch result {
            case .success(let image):
                self.movieImage = image
                print(image)
            case .failure(let error):
                self.onFetchMovieFailure?(error)
            }
        }
    }
}
