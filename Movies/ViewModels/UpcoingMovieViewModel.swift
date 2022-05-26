//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import Foundation

protocol UpcomingMovieViewModel {
    var movie: Movie { get set }
//    func fetchImage(posterPath: String)
}

final class UpcomingMovieDefaultViewModel {
    var movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
}

//extension UpcomingMovieDefaultViewModel: UpcomingMovieViewModel {
//
//    func fetchImage(posterPath: String) {
//        Task {
//            let result = await ImageService.shared.fetchMovieImage(path: posterPath)
//            switch result {
//            case .success(let image):
////                self.movieImage = image
//                print(image)
//            case .failure(let error):
//                self.onFetchMovieFailure?(error)
//            }
//        }
//    }
//}
