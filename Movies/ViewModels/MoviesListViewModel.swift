//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 25.05.2022.
//

import UIKit

protocol MoviesListViewModel: AnyObject {
    var upcomingMovies:     Observed<[Movie]> { set get }
    var allGenres:          Observed<[Genre]> { get set }
    var todayMovies:        Observed<[Movie]> { get set }
    var topRatedMovies:     Observed<[Movie]> { get set }
    var popularMovies:      Observed<[Movie]> { get set }

    func fetchData()
}

final class DefaultMoviesListViewModel {

    var upcomingMovies  =  Observed<[Movie]>([])
    var todayMovies     =  Observed<[Movie]>([])
    var topRatedMovies  =  Observed<[Movie]>([])
    var popularMovies   =  Observed<[Movie]>([])
    var allGenres       =  Observed<[Genre]>([])

    var allMoviesCached = NSCache<NSString, MoviesResponse>()

    var packOfCategories = [Observed<[Movie]>]()

    private let moviesService: MovieService
    private let genresService: GenreService

    init(moviesService: MovieService, genresService: GenreService) {
        self.moviesService = moviesService
        self.genresService = genresService
        fetchGenresList()
        fetchData()
    }
}

extension DefaultMoviesListViewModel: MoviesListViewModel {

    func fetchData() {
        Task {
            let upcomingMoviesResponse = await moviesService.getUpcomingMovies()
            let nowPlayingMoviesResponse = await moviesService.getNowPlayingMovies()
            let topRatedMoviesResponse = await moviesService.getTopRatedMovies()
            let popularMoviesResponse = await moviesService.getPopularMovies()

            switch upcomingMoviesResponse {
            case .success(let upcoming):
                DispatchQueue.main.async {
                    self.upcomingMovies.value = upcoming.movies
                }
            case .failure(let error):
                print("Error ", error)
            }

            switch nowPlayingMoviesResponse {
            case .success(let nowPlaying):
                DispatchQueue.main.async {
                    self.todayMovies.value = nowPlaying.movies
                }
            case .failure(let error):
                print("Error caused ",error)
            }

            switch topRatedMoviesResponse {
            case .success(let topRated):
                DispatchQueue.main.async {
                    self.topRatedMovies.value = topRated.movies
                }
            case .failure(let error):
                print("Error caused ",error)
            }

            switch popularMoviesResponse {
            case .success(let popular):
                DispatchQueue.main.async {
                    self.popularMovies.value = popular.movies
                }
            case .failure(let error):
                print("Error caused ",error)
            }
        }
    }

    private func fetchGenresList() {
        Task {
            let result = await genresService.getGenresList()
            switch result {
            case .success(let genresList):
                DispatchQueue.main.async {
                    self.allGenres.value = genresList.genres
                    Task {
                        await self.populate(movies: &self.upcomingMovies.value, with: genresList.genres)
                        await self.populate(movies: &self.todayMovies.value, with: genresList.genres)
                        await self.populate(movies: &self.topRatedMovies.value, with: genresList.genres)
                        await self.populate(movies: &self.popularMovies.value, with: genresList.genres)
                    }
                }
            case .failure(let error):
                print("error getting genres ", error)
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
        let filtered = allGenres.value.filter {
            genreIDs.contains($0.id)
        }
        return filtered.map {
            $0.name
        }
    }
}
