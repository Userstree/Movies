//
//  MovieCell.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 17.05.2022.
//

import UIKit
import SnapKit

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var movieRating = UILabel()
        .textColor(.white)
        .font(ofSize: 12, weight: .semibold)
        .textAlignment(.center)
        .cornerRadius(6)
        .clipsToBounds(true)
    
    lazy var movieTitle = UILabel()
        .textColor(.white)
        .font(ofSize: 16, weight: .semibold)
    
    lazy var genreSubtext = UILabel()
        .font(ofSize: 12, weight: .regular)
        .numberOfLines(0)
        .textColor(.gray) 
    
    private lazy var mainVerticalStack = UIStackView()
        .axis(.vertical)
        .alignment(.leading)
        .spacing(2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        [imageView, movieTitle, genreSubtext].forEach(mainVerticalStack.addArrangedSubview)
        [mainVerticalStack, movieRating].forEach(contentView.addSubview)
        movieRating.bringSubviewToFront(imageView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainVerticalStack.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: contentView.frame.width * 0.75, height: contentView.frame.height * 0.7))
        }
        
        movieRating.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading).offset(10)
            $0.top.equalTo(imageView.snp.top).offset(10)
            $0.size.equalTo(CGSize(width: 45, height: 25))
        }
        
        movieTitle.snp.makeConstraints {
            $0.height.equalTo(25)
        }
    }
    
    private func loadImage(path: String, completion: @escaping (Result<UIImage, ErrorResponse>) -> Void) {
        Task {
            let result = await ImageService.shared.fetchMovieImage(path: path)
            completion(result)
        }
    }

    func setup(with movie: Movie) {
        self.movieTitle.text = movie.title
        self.movieRating.text = "★\(movie.rating)"
        self.movieRating.backgroundColor = movie.ratingLabelColor.labelColor
        self.genreSubtext.text = "Horror, Movie, Drama, Fantasy, Adventure"

        loadImage(path: movie.posterPath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posterImage):
                DispatchQueue.main.async {
                    self.imageView.image = posterImage
                }
            case .failure(let error):
                print("Can't set image to card with ", error)
            }
        }
    }
}
