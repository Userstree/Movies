//
//  MovieCardCell.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 20.05.2022.
//

import UIKit
import SnapKit

class MovieCardCell: UITableViewCell {
    
    static let identifier = "MovieCardCell"
    
    lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var movieRating = UILabel()
        .backgroundColor(.orange)
        .textColor(.white)
        .font(ofSize: 16, weight: .semibold)
        .textAlignment(.center)
        .cornerRadius(6)
        .clipsToBounds(true)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }

    private func configureViews() {
        [imgView, movieRating].forEach(contentView.addSubview)
        movieRating.bringSubviewToFront(imgView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        imgView.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges).inset(UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
        }
        
        movieRating.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.leading).offset(15)
            $0.top.equalTo(imgView.snp.top).offset(15)
            $0.size.equalTo(CGSize(width: 65, height: 35))
        }
    }

    func configure(with model: Movie) {
        let path = model.posterPath
        self.movieRating.text = "★\(model.rating)"
        self.movieRating.backgroundColor = model.ratingLabelColor.labelColor
        loadImage(path: path) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imgView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func loadImage(path: String, completion: @escaping (Result<UIImage, ErrorResponse>) -> Void) {
        Task {
            let result = await ImageService.shared.fetchImage(path: path)
            completion(result)
        }
    }
}
