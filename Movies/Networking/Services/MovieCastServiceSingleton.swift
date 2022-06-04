//
// Created by Dossymkhan Zhulamanov on 27.05.2022.
//

import UIKit

protocol MovieCastService {
    func getMovieCast(movieID: Int) async -> Result<CastList, ErrorResponse>
}

protocol PersonService {
    func getPersonInfo(personId: Int) async -> Result<Person, ErrorResponse>
}

final class MovieCastServiceSingleton {
    static let shared: MovieCastService = MovieCastServiceImpl()
    static let sharedPerson: PersonService = PersonServiceImpl()

    init() {}
}

class MovieCastServiceImpl: BaseRepository, MovieCastService {

    init() {
        super.init(basePath: "movie")
    }

    func getMovieCast(movieID: Int) async -> Result<CastList, ErrorResponse> {
        await get("/\(movieID)/credits")
    }
}

class PersonServiceImpl: BaseRepository, PersonService {

    init() {
        super.init(basePath: "person")
    }

    func getPersonInfo(personId: Int) async -> Result<Person, ErrorResponse> {
        await get("/\(personId)")
    }
}