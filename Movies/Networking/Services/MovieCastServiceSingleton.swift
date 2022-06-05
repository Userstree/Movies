//
// Created by Dossymkhan Zhulamanov on 27.05.2022.
//

import UIKit

protocol MovieCastService {
    func getMovieCast(movieID: Int) async -> Result<CastList, ErrorResponse>
}

final class MovieCastServiceSingleton {

    static let shared: MovieCastService = MovieCastServiceImpl()

    init() {}
}
