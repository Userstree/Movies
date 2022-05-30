//
// Created by Dossymkhan Zhulamanov on 30.05.2022.
//

import Foundation

struct CastList: Codable {
    let id: Int
    let cast: [ActorCast]

//    enum CodingKeys: String, CodingKey {
//        case id
//        case cast = "cast"
//    }
}
