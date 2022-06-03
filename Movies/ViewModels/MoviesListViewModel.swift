//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 25.05.2022.
//

import UIKit

protocol MoviesListViewModel: AnyObject {
    var upcomingMovies: [Movie] { set get }
    var allGenres: [Genre] { get set }
    var todayMovies: [Movie] { get set }
    var topRatedMovies: [Movie] { get set }
    var popularMovies: [Movie] { get set }

    var onFetchSucceed: SuccessCallback? { set get }
    var onFetchFailure: FailureCallback? { set get }

    func fetchData()
}

final class DefaultMoviesListViewModel {

    var upcomingMovies: [Movie] = []

    var todayMovies: [Movie] = []

    var topRatedMovies: [Movie] = []

    var popularMovies: [Movie] = []

    var allGenres: [Genre] = []

    var onFetchSucceed: SuccessCallback?

    var onFetchFailure: FailureCallback?

    private let service: MovieServiceable

    init(service: MovieServiceable) {
        self.service = service
        fetchGenresList()
        fetchData()
    }
}

extension DefaultMoviesListViewModel: MoviesListViewModel {

    func fetchData() {
        Task {
            let upcomingMoviesResponse = await service.getUpcomingMovies()
            switch upcomingMoviesResponse {
            case .success(let upComing):
                DispatchQueue.main.async {
                    self.upcomingMovies = upComing.movies
                    self.onFetchSucceed?()
                }
            case .failure(let error):
                self.onFetchFailure?(error)
            }

            let nowPlayingMoviesResponse = await service.getNowPlayingMovies()
            switch nowPlayingMoviesResponse {
            case .success(let moviesList):
                DispatchQueue.main.async {
                    self.todayMovies = moviesList.movies
                    self.onFetchSucceed?()
                }
            case .failure(let error):
                self.onFetchFailure?(error)
            }

            let topRatedMoviesResponse = await service.getTopRatedMovies()
            switch topRatedMoviesResponse {
            case .success(let moviesList):
                DispatchQueue.main.async {
                    self.topRatedMovies = moviesList.movies
                    self.onFetchSucceed?()
                }
            case .failure(let error):
                self.onFetchFailure?(error)
            }

            let popularMoviesResponse = await service.getPopularMovies()
            switch popularMoviesResponse {
            case .success(let moviesList):
                DispatchQueue.main.async {
                    self.popularMovies = moviesList.movies
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
                    Task {
                        await self.populate(movies: &self.upcomingMovies, with: genresList.genres)
                        await self.populate(movies: &self.todayMovies, with: genresList.genres)
                        await self.populate(movies: &self.topRatedMovies, with: genresList.genres)
                        await self.populate(movies: &self.popularMovies, with: genresList.genres)
                    }
                    self.onFetchSucceed?()
                }
            case .failure(let error):
                print("error getting genres ", error)
                self.onFetchFailure?(error)
            }
        }
    }

    private func populate(movies: inout [Movie], with genres: [Genre]) async {
        for i in 0..<movies.count {
            guard let listOfIDs = movies[i].genreIDs else {
                return
            }
            let genresStringList = makeGenresList(genreIDs: listOfIDs)
            movies[i].genres = genresStringList
        }
    }

    private func makeGenresList(genreIDs: [Int]) -> [String] {
        let filtered = allGenres.filter {
            genreIDs.contains($0.id)
        }
        return filtered.map {
            $0.name
        }
    }
}
