//
// Created by Dossymkhan Zhulamanov on 05.06.2022.
//

import Foundation

class MovieCastServiceImpl: BaseRepository, MovieCastService {

    init() {
        super.init(basePath: "movie")
    }

    func getMovieCast(movieID: Int) async -> Result<CastList, ErrorResponse> {
        await get("/\(movieID)/credits")
    }
}
