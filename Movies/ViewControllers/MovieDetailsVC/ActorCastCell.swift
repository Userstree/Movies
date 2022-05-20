//
//  CommentCell.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import UIKit

class ActorCastCell: UICollectionViewCell {
    
    static let identifier = "ActorCastCell"
    
    lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var nameLabel = UILabel()
        .numberOfLines(2)
        .textColor(.white)
        .font(ofSize: 14, weight: .semibold)
    
    lazy var roleLabel = UILabel()
        .textColor(.gray)
        .numberOfLines(1)
        .textColor(.white)
        .font(ofSize: 12, weight: .regular)
    
    lazy private var mainStack = UIStackView()
        .axis(.vertical)
        .alignment(.leading)
        .spacing(2)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureViews()
    }
    
    private func configureViews() {
        [imgView, nameLabel, roleLabel].forEach(mainStack.addArrangedSubview)
        contentView.addSubview(mainStack)
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainStack.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
        
        imgView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: contentView.frame.width - 40, height: contentView.frame.height - 40))
        }
    }
    
    func configure(with model: HollywoodActor) {
        guard let image = model.image else { return }
        self.imgView.image = image
        self.nameLabel.text = model.name
        self.roleLabel.text = model.role
    }
}
