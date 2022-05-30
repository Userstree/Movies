//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import UIKit

protocol ImageServiceable {
    func fetchImage(path: String) async -> Result<UIImage, ErrorResponse>
}

struct ImageService {
    static let shared = ImageService()

    init() {}
}

extension ImageService: ImageServiceable, ImageRequest {

    func fetchImage(path: String) async -> Result<UIImage, ErrorResponse> {
        return await sendImageRequest(endpoint: MovieImageEndpoint.w500, imagePath: path)
    }
}
