//
// Created by Dossymkhan Zhulamanov on 27.05.2022.
//

import UIKit

protocol MovieCastServiceable {
    func getMovieCast(movieID: Int) async -> Result<CastList, ErrorResponse>
    func getPersonInfo(personId: Int) async -> Result<Person, ErrorResponse>
}

final class MovieCastService: MovieInfoRequest, MovieCastServiceable {
    static let shared = MovieCastService()

    init() {}
}

extension MovieCastService: PersonInfoRequest {
    
    func getMovieCast(movieID: Int) async -> Result<CastList, ErrorResponse> {
        return await sendMovieInfoRequest(endpoint: MovieCastListEndpoint.movie, forMovieWithID: movieID, responseModel: CastList.self)
    }
    
    func getPersonInfo(personId: Int) async -> Result<Person, ErrorResponse> {
        return await sendPersonInfoRequest(endpoint: PersonEndpoint.person, personId: personId, responseModel: Person.self)
    }
}
