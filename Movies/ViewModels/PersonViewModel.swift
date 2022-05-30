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

final class DefaultPersonViewModel {
    var person: Person
    
    init(viewModel: PersonViewModel) {
        self.person = viewModel.person
    }
}

extension DefaultPersonViewModel: PersonViewModel {
    private func fetchPersonInfo()
}

