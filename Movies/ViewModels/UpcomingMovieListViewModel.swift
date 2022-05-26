//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 25.05.2022.
//

import UIKit

protocol UpcomingMovieListViewModel: AnyObject {
//    var images: [UIImage] { get set }
    var movies: [Movie] { set get }
    var onFetchMovieSucceed: (() -> Void)? { set get }
    var onFetchMovieFailure: ((Error) -> Void)? { set get }
    func fetchData()
    func fetchImages(posterPath: String)
    var movieImage: UIImage? { get }
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
                self.fetchImages(posterPath: upComing.movies[0].posterPath)
                self.onFetchMovieSucceed?()
            case .failure(let error):
                self.onFetchMovieFailure?(error)
            }
        }
    }
    
    func fetchImages(posterPath: String) {
        Task {
            let result = await service.fetchMovieImage(path: posterPath)
            switch result {
            case .success(let image):
                self.movieImage = image
            case .failure(let error):
                self.onFetchMovieFailure?(error)
            }
        }
    }
}
