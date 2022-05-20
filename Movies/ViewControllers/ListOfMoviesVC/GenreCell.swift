//
//  GenreCell.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 20.05.2022.
//

import UIKit
import SnapKit

class GenreCell: UICollectionViewCell {
    
    static let identifier = "GenreCell"
    
    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.layer.borderColor = UIColor.orange.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureViews()
    }
    
    private func configureViews() {
        contentView.addSubview(genreLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        genreLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }
}
