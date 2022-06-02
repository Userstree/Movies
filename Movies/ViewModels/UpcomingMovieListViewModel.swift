//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 25.05.2022.
//

import UIKit

protocol UpcomingMovieListViewModel: AnyObject {
    var movies: [Movie] { set get } 

    var onFetchSucceed: SuccessCallback? { set get }
    var onFetchFailure: FailureCallback? { set get }

    func fetchData()
}

final class DefaultUpcomingMovieListViewModel {
    
    var movies: [Movie] = []
    
    var allGenres: [Genre] = []
    
    var onFetchSucceed: SuccessCallback?
    
    var onFetchFailure: FailureCallback?
    
    private let service: MovieServiceable
    
    init(service: MovieServiceable) {
        self.service = service
        fetchGenresList()
    }

    convenience init() {
        self.init(service: MovieService())
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
                    self.onFetchSucceed?()
                }
            case .failure(let error):
                self.onFetchFailure?(error)
            }
        }
    }
    
    private func fetchGenresList() {
        Task {
            let result = await service.getGenresList()
            switch result {
            case .success(let genresList):
                DispatchQueue.main.async {
                    self.allGenres = genresList.genres
                    genresList.genres.forEach { genre in
                        print(genre["name"])
                    }
                    self.onFetchSucceed?()
                }
            case .failure(let error):
                print("error getting genres ", error)
                self.onFetchFailure?(error)
            }
        }
    }

    private func makeGenresFromIDs() {
//        var genresDict: [Int: String] = allGenres.map(<#T##transform: (Genre) throws -> T##(Movies.Genre) throws -> T#>)
//        movies.forEach { movie in
//
//        }
    }
}
