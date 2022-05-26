//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import Foundation

protocol UpcomingMovieViewModel {
    var movie: Movie { get set
}

    final  class UpcomingMovieDefaultViewModel: UpcomingMovieViewModel {
        var movie: Movie

        init(movie: Movie) {
            self.movie = movie
        }
    }
}