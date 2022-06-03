//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 25.05.2022.
//

import UIKit

protocol UpcomingMovieListViewModel: AnyObject {
    var movies: [Movie] { set get }
    var allGenres: [Genre] { get set }

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
        fetchData()
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
                    self.populate(movies: &self.movies, with: genresList.genres)
                    self.onFetchSucceed?()
                }
            case .failure(let error):
                print("error getting genres ", error)
                self.onFetchFailure?(error)
            }
        }
    }

    private func populate(movies: inout [Movie], with genres: [Genre])  {
        for i in 0..<movies.count {
            guard let listOfIDs = movies[i].genreIDs else { return }
            let genresStringList = makeGenresList(genreIDs: listOfIDs)
            movies[i].genres = genresStringList
            print(movies[i].genres)
        }
    }

    private func makeGenresList(genreIDs: [Int]) -> [String] {
        let filtered = allGenres.filter { genreIDs.contains($0.id) }
        return filtered.map { $0.name }
    }
}
