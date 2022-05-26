//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import UIKit

enum Rating {
    case bad
    case normal
    case good

    var labelColor: UIColor {
        switch self {
        case .bad:
            return .systemRed
        case .normal:
            return .systemOrange
        case .good:
            return .systemGreen
        }
    }
}