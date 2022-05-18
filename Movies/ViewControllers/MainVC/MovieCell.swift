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
        let image = UIImageView()
        return image
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        [imageView, title].forEach(mainStack.addArrangedSubview)
        contentView.addSubview(mainStack)
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainStack.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom)
        }
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: contentView.frame.width * 0.85, height: contentView.frame.height * 0.8))
        }
    }
    
    func setup(with movie: Movie) {
        guard let image = movie.image, let title = movie.title else { return }
        self.imageView.image = image
        self.title.text = title
    }
}
