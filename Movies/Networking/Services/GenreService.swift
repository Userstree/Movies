//
// Created by Dossymkhan Zhulamanov on 04.06.2022.
//

import Foundation

protocol GenreService {
    func getGenresList() async -> Result<GenresList, ErrorResponse>
}