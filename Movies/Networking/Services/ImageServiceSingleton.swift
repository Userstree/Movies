//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import UIKit

protocol ImageService {
    func fetchImage(path: String) async -> Result<UIImage, ErrorResponse>
}

class ImageServiceSingleton {

    init() {}

    static let shared: ImageService = ImageServiceImpl()
}
