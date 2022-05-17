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
    
    private lazy var mainStack = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        [imageView, title].forEach(contentView.addSubview)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
    }
    
    func setup(with movie: Movie) {
        self.imageView.image = movie.image!
        self.title.text = movie.title
    }
}
