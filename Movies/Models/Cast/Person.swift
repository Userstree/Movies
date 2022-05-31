//
//  Actor.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 20.05.2022.
//

import UIKit

struct Person: Codable {
    let biography: String
    let birthday: String?
    let profileImage: String?
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case birthday
        case biography
        case id
        case profileImage = "profile_path"
    }
    init(){}
}
