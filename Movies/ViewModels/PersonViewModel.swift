//
//  MovieCastListViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 28.05.2022.
//

import Foundation

protocol PersonViewModel {
    var person: Person { get set }
}

typealias SuccessCallback = () -> Void
typealias FailureCallback = (Error) -> Void

final class DefaultPersonViewModel {
    var person = Person()
    var personId: Int

    init(personId: Int) {
        self.personId = personId
        initPerson()
    }

    var onFetchPersonSucceed: SuccessCallback?

    var onFetchPersonFailure: FailureCallback?
}

extension DefaultPersonViewModel: PersonViewModel {

    private func fetchPersonInfo(completion: @escaping (Result<Person, ErrorResponse>) -> Void) {
        Task {
            let result = await MovieCastService.shared.getPersonInfo(personId: person.id)
            completion(result)
        }
    }

    private func initPerson() {
        fetchPersonInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let person):
                DispatchQueue.main.async {
                    self.person = person
                    onFetchPersonSucceed()?
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("mapping person data with ", error)
                    onFetchPersonFailure(error)?
                }
            }
        }
    }
}

