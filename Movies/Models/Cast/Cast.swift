//
// Created by Dossymkhan Zhulamanov on 27.05.2022.
//

import Foundation

struct Cast: Codable {
    let id: Int
    let knownFor: String
    let profileImage: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case knownFor = "known_for_department"
        case profileImage = "profile_path"
    }
}