//
//  CommentCell.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import UIKit

class CommentCell: UITableViewCell {
    
    static let identifier = "CommentCell"
    
    private lazy var heartLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "💙"
        return label
    }()
    
    lazy var personNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var commentDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    private lazy var leftSideStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 0
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var rightSideStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 0
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 0
        stack.axis = .horizontal
        return stack
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func configureView() {
        [heartLabel, personNameLabel].forEach(leftSideStack.addArrangedSubview)
        [commentDescriptionLabel, dateLabel].forEach(rightSideStack.addArrangedSubview)
        [leftSideStack, rightSideStack].forEach(mainStack.addArrangedSubview)
        contentView.addSubview(mainStack)
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainStack.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp_margins)
        }
    }
}

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//}
