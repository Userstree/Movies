//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import UIKit

protocol UpcomingMovieViewModel {
    var movie: Movie { get set }
    var castOfActors: [ActorCast] { get set }
    
    func fetchImage(posterPath: String, completion: @escaping  (Result<UIImage, ErrorResponse>)-> Void)
    func getCast(completion: @escaping (Result<CastList, ErrorResponse>) -> Void)
    
    var onFetchMovieSucceed: (() -> Void)? { set get }
    var onFetchMovieFailure: ((Error) -> Void)? { set get }
}

final class DefaultUpcomingMovieViewModel {
    var movie: Movie
    var castOfActors: [ActorCast] = []

    init(movie: Movie) {
        self.movie = movie
        initCast()
    }
    
    var onFetchMovieSucceed: (() -> Void)?
    
    var onFetchMovieFailure: ((Error) -> Void)?
}

extension DefaultUpcomingMovieViewModel: UpcomingMovieViewModel {

    func fetchImage(posterPath: String, completion: @escaping  (Result<UIImage, ErrorResponse>) -> Void) {
        Task {
            let result = await ImageService.shared.fetchImage(path: posterPath)
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getCast(completion: @escaping (Result<CastList, ErrorResponse>) -> Void) {
        Task {
            let result = await MovieCastService.shared.getMovieCast(movieID: movie.id)
            completion(result)
        }
    }
    
    private func initCast() {
        getCast { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let castList):
                DispatchQueue.main.async {
                    self.castOfActors = castList.cast
                    self.onFetchMovieSucceed?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("error initializing ", error)
                    self.onFetchMovieFailure?(error)
                }
            }
        }
    }
}
