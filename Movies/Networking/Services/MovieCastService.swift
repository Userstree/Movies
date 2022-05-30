//
// Created by Dossymkhan Zhulamanov on 27.05.2022.
//

import UIKit

protocol MovieCastServiceable {
    func getMovieCast(movieID: Int) async -> Result<CastList, ErrorResponse>
}

final class MovieCastService: MovieInfoRequest, MovieCastServiceable {
    static let shared = MovieCastService()

    init() {}
}

extension MovieCastService {
    func getMovieCast(movieID: Int) async -> Result<CastList, ErrorResponse> {
        return await sendMovieInfoRequest(endpoint: CastEndpoint.movie, forMovieWithID: movieID, responseModel: CastList.self)
    }
}
