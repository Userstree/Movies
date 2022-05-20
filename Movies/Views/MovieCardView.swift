//
//  MovieCardView.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import UIKit
import SnapKit

class MovieCardView: UIView {

    var ratingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        return label
    }()
    
    var mainImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(_ frame: CGRect, of image: UIImage, with rating: Double) {
        self.mainImageView.image = image
        self.ratingLabel.text = String(format: "★" + "%.1f", rating)
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        [mainImageView, ratingLabel].forEach(addSubview)
        ratingLabel.bringSubviewToFront(mainImageView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainImageView.snp.makeConstraints {
            $0.edges.equalTo(self.snp.edges)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.top).offset(15)
            $0.leading.equalTo(mainImageView.snp.leading).offset(15)
            $0.size.equalTo(CGSize(width: 55, height: 30))
        }
    }
}
