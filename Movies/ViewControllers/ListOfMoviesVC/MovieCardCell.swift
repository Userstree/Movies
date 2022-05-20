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
        .font(ofSize: 12, weight: .semibold)
        .textAlignment(.center)
        .cornerRadius(6)
        .clipsToBounds(true) 
        .text("★3.4")
    
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
            $0.size.equalTo(CGSize(width: 45, height: 25))
        }
    }

    func configure(with models: DumbMovie) {
        self.imgView.image = models.image
    }
}