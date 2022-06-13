//
// Created by Dossymkhan Zhulamanov on 05.06.2022.
//

import UIKit

class ImageServiceImpl: BaseRepository, ImageService {

    init() {
        super.init(basePath: "w200")
    }

    func fetchImage(path: String) async -> Result<UIImage, ErrorResponse> {
        await getImage(path)
    }
}

