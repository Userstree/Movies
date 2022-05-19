//
//  ViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 17.05.2022.
//

import UIKit
import SnapKit

struct DumbMovie {
    let title: String?
    let image: UIImage?
}

class MainViewController: UIViewController {
    
    private var movieSet = [DumbMovie(title: "Horse", image: UIImage(named: "Horse")),
                            DumbMovie(title: "Harry Potter", image: UIImage(named: "Harry Potter"))]
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 275)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkVioletBackgroundColor
        settingUpTitle()
        configureViews()
    }
    
    private func settingUpTitle() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Movies"
    }
    
    private func configureViews() {
        view.addSubview(collectionView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            $0.centerX.equalTo(view.snp.centerX)
            $0.size.equalTo(CGSize(width: self.view.frame.width - 10, height: self.view.frame.height / 3 + 10))
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.setup(with: movieSet[indexPath.item])
        cell.imageView.layer.cornerRadius = 6
        cell.imageView.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieVC = MovieViewController(movie: movieSet[indexPath.item], genre: ["adventure, crime, mystery"])
        self.navigationController?.pushViewController(movieVC, animated: true)
    }
}
