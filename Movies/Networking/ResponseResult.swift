//
// Created by Dossymkhan Zhulamanov on 12.06.2022.
//

import UIKit

public enum ResponseResult<Success> {
    case success(Success)
}

extension ResponseResult : Sendable where Success : Sendable {
}
