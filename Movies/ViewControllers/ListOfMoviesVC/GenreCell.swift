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
    
    lazy var genreLabel = UILabel()
        .font(ofSize: 14, weight: .medium)
        .textColor(.white)
        .textAlignment(.center)
        .cornerRadius(6)
        .borderColor(.orange)
        .borderWidth(1)

    // MARK: - Controller lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureViews()
    }

    // MARK: - Configuration of the View
    
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
