//
//  Actor.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 20.05.2022.
//

import UIKit

struct Person: Codable {
    let biography: String
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case biography
        case profileImage = "profile_path"
    }
}
