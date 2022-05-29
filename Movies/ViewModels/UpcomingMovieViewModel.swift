//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import UIKit

protocol UpcomingMovieViewModel {
    var movie: Movie { get set }
    func fetchImage(posterPath: String, completion: @escaping  (Result<UIImage, ErrorResponse>)-> Void)
}

final class UpcomingMovieDefaultViewModel {
    var movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
}

extension UpcomingMovieDefaultViewModel: UpcomingMovieViewModel {

    func fetchImage(posterPath: String, completion: @escaping  (Result<UIImage, ErrorResponse>) -> Void) {
        Task {
            let result = await ImageService.shared.fetchMovieImage(path: posterPath)
            completion(result)
        }
    }
    
    func getCast(completion: @escaping (Result<Cast, ErrorResponse>) -> Void) {
        Task {
            let result = await MovieCastService.shared.getMovieCast(movieID: movie.id)
            completion(result)
        }
    }
}
