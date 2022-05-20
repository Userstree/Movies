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
    
    lazy var movieCard = MovieCardView()
    
    lazy var movieRating: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.text = "★3.4"
        return label
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var genreSubtext: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private lazy var mainStack = UIStackView()
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
        [imageView, movieTitle, genreSubtext].forEach(mainStack.addArrangedSubview)
        [mainStack, movieRating].forEach(contentView.addSubview)
        movieRating.bringSubviewToFront(imageView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainStack.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom)
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
    
    func setup(with movie: DumbMovie) {
        guard let image = movie.image, let title = movie.title else { return }
        self.imageView.image = image
        self.movieTitle.text = title
        self.genreSubtext.text = "Horror, Movie, Drama, Fantasy, Adventure"
    }
}
