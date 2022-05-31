//
//  Actor.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 20.05.2022.
//

import UIKit

struct Person: Codable {
    let biography: String
    let id: Int
    let name: String
    let knownFor: String
    let birthday: String?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case birthday
        case biography
        case id
        case name
        case knownFor = "known_for_department"
        case profileImage = "profile_path"
    }
}
