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
        print("Before TASK\n")
        Task {
            let result = await service.getUpcomingMovies()            
            switch result {
            case .success(let upComing):
                self.movies = upComing.movies
//                print(upComing.movies)
                self.onFetchMovieSucceed?()
            case .failure(let error):
                self.onFetchMovieFailure?(error)
            }
        }
    }
}
