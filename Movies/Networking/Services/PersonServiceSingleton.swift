//
// Created by Dossymkhan Zhulamanov on 05.06.2022.
//

import Foundation

protocol PersonService {
    func getPersonInfo(personId: Int) async -> Result<Person, ErrorResponse>
}

class PersonServiceSingleton {

    static let sharedPerson: PersonService = PersonServiceImpl()

    init() {}
}
