//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import UIKit

protocol MovieViewModel {
    var movie: Movie { get set }
    var castOfActors: Observed<[ActorCast]> { get set }

    func fetchImage(posterPath: String, completion: @escaping (Result<UIImage, ErrorResponse>) -> Void)
    func getCast(completion: @escaping (Result<CastList, ErrorResponse>) -> Void)
}

final class DefaultMovieViewModel {
    var movie: Movie
    var castOfActors = Observed<[ActorCast]>([])

    init(movie: Movie) {
        self.movie = movie
        initCast()
    }
}

extension DefaultMovieViewModel: MovieViewModel {

    func fetchImage(posterPath: String, completion: @escaping (Result<UIImage, ErrorResponse>) -> Void) {
        Task {
            let result = await ImageServiceSingleton.shared.fetchImage(path: posterPath)
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    func getCast(completion: @escaping (Result<CastList, ErrorResponse>) -> Void) {
        Task {
            let result = await MovieCastServiceSingleton.shared.getMovieCast(movieID: movie.id)
            completion(result)
        }
    }

    private func initCast() {
        getCast { result in
            switch result {
            case .success(let castList):
                self.castOfActors.value = castList.cast
            case .failure(let error):
                print("error initializing ", error)
            }
        }
    }
}
