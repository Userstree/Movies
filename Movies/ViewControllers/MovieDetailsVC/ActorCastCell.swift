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
        imageView.layer.cornerRadius = 120 / 2
        imageView.clipsToBounds = true
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
    
    lazy private var mainVerticalStack = UIStackView()
        .axis(.vertical)
        .alignment(.leading)
        .spacing(2)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }
    
    private func configureViews() {
        [imgView, nameLabel, roleLabel].forEach(mainVerticalStack.addArrangedSubview)
        contentView.addSubview(mainVerticalStack)
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainVerticalStack.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
        
        imgView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: contentView.frame.width - 40, height: contentView.frame.height - 40))
        }
    }
    
    func configure(with model: ActorCast) {
        self.nameLabel.text = model.name
        self.roleLabel.text = model.knownFor
        
        guard let profileImagePath = model.profileImage else { return }
        loadImage(path: profileImagePath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imgView.image = image
                }
            case .failure(let error):
                print("Failed to set profile image", error)
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
