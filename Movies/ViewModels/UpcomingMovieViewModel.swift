//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import UIKit

protocol UpcomingMovieViewModel {
    var movie: Movie { get set }
    var castList: [Cast]? { get set }
    func fetchImage(posterPath: String, completion: @escaping  (Result<UIImage, ErrorResponse>)-> Void)
    func getCast(completion: @escaping (Result<CastList, ErrorResponse>) -> Void)
}

final class UpcomingMovieDefaultViewModel {
    var movie: Movie
    var castList: [Cast]?

    init(movie: Movie) {
        self.movie = movie
    }
}

extension UpcomingMovieDefaultViewModel: UpcomingMovieViewModel {

    func fetchImage(posterPath: String, completion: @escaping  (Result<UIImage, ErrorResponse>) -> Void) {
        Task {
            let result = await ImageService.shared.fetchMovieImage(path: posterPath)
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getCast() {
        Task {
            let result = await MovieCastService.shared.getMovieCast(movieID: movie.id)
            switch result {
            case .success(let castList):
                DispatchQueue.main.async {
                    self.castList = castList
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("error happened during ")
                }
            }
        }
    }
}
