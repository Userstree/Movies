//
//  MovieCastListViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 28.05.2022.
//

import UIKit

typealias SuccessCallback = () -> Void
typealias FailureCallback = (Error) -> Void

protocol PersonViewModel {
    var person: Person? { get set }
    var personID: Int { get set }
    var onFetchPersonSucceed: SuccessCallback? { get set }
    var onFetchPersonFailure: FailureCallback? { get set }
    var profileImage: ((UIImage) -> Void)? {get set }
}

final class DefaultPersonViewModel {
    var person: Person?
    var personID: Int

    init(personID: Int) {
        self.personID = personID
        initPerson()
    }

    var profileImage: ((UIImage) -> Void)?

    var onFetchPersonSucceed: SuccessCallback?

    var onFetchPersonFailure: FailureCallback?
}

extension DefaultPersonViewModel: PersonViewModel {

    private func fetchPersonInfo(completion: @escaping (Result<Person, ErrorResponse>) -> Void) {
        Task {
            let result = await MovieCastServiceSingleton.sharedPerson.getPersonInfo(personId: personID)
            completion(result)
        }
    }

    private func initPerson() {
        fetchPersonInfo { result in
            switch result {
            case .success(let person):
                DispatchQueue.main.async {
                    self.person = person
                    self.setPersonImage()
                    self.onFetchPersonSucceed?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("mapping person data with ", error)
                    self.onFetchPersonFailure?(error)
                }
            }
        }
    }

    private func personImageRequest(completion: @escaping (Result<UIImage, ErrorResponse>) -> Void) {
        guard let path = person?.profileImage else { return }
        Task {
            let result = await ImageServiceSingleton.shared.fetchImage(path: path)
            completion(result)
        }
    }

    func setPersonImage() {
        personImageRequest { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.profileImage?(image)
                }
            case .failure(let error):
                print("Could get profile image ", error)
            }
        }
    }
}

