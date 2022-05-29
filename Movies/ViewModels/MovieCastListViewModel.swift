//
//  MovieCastListViewModel.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 28.05.2022.
//

import Foundation

protocol MovieCastListViewModel {
    var castList: [Cast] { get set }
}

final class MovieCastListDefaultViewModel: MovieCastListViewModel {
    var castList: [Cast] = []
}
