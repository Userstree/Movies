//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import UIKit

protocol ImageService {
    func fetchImage(path: String) async -> Result<UIImage, ErrorResponse>
}

struct ImageServiceSingleton {
    static let shared: ImageService = ImageServiceImpl()

    init() {}
}

class ImageServiceImpl: BaseRepository, ImageService {

    init() {
        super.init(basePath: "w500")
    }

    func fetchImage(path: String) async -> Result<UIImage, ErrorResponse> {
        await getImage(path)
    }
}
