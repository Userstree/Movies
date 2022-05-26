//
// Created by Dossymkhan Zhulamanov on 26.05.2022.
//

import UIKit

protocol ImageServiceable {
    func fetchMovieImage(path: String) async -> Result<UIImage, ErrorResponse>
}

final class ImageService {
    static let shared = ImageService()

    init() {}
}

extension ImageService: ImageServiceable, ImageRequest {

    func fetchMovieImage(path: String) async -> Result<UIImage, ErrorResponse> {
        return await sendImageRequest(endpoint: MovieImageEndpoint.w500, path: path)
    }
}
