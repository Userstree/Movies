//
//  CollectionCell.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 19.05.2022.
//

import UIKit
import SnapKit

protocol CollectionCellDelegate {
    func passIndexOfCollectionCell(collectionViewItemIndex: Int)
}

class SubCollectionViewCell: UITableViewCell {
    
    static let identifier = "CollectionCell"
    
    var models = [DumbMovie]()
    
    var delegate: CollectionCellDelegate?
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: contentView.frame.width / 2, height: contentView.frame.height - 20)
        layout.scrollDirection = .horizontal
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }
    
    private func configureViews() {
        contentView.addSubview(collectionView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide.snp.margins)
        }
    }

    func configure(with models: [DumbMovie]) {
        self.models = models
        collectionView.reloadData()
    }
}

extension SubCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.setup(with: models[indexPath.item])
        cell.imageView.layer.cornerRadius = 6
        cell.imageView.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.passIndexOfCollectionCell(collectionViewItemIndex: indexPath.item)
    }
}
