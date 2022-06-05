//
// Created by Dossymkhan Zhulamanov on 05.06.2022.
//

import Foundation

class PersonServiceImpl: BaseRepository, PersonService {

    init() {
        super.init(basePath: "person")
    }

    func getPersonInfo(personId: Int) async -> Result<Person, ErrorResponse> {
        await get("/\(personId)")
    }
}