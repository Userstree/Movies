//
//  MovieViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .gray
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    //>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<
    private var imageWithLabel: MovieCardView!
    
    lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy private var movieInfoStack = UIStackView()
        .axis(.vertical)
        .spacing(2)
        .alignment(.leading)

    lazy var castLalel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy private var castCollectionView: UICollectionView = {
        let collection = UICollectionView()
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 100)
    }
    
    init(movie: DumbMovie, genre: [String]) {
        super.init(nibName: nil, bundle: nil)
        guard let image = movie.image else { return }
        self.imageWithLabel = MovieCardView(.zero, of: image, with: 8.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    private func configureView() {
        [imageWithLabel].forEach(scrollView.addSubview)
        view.addSubview(scrollView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        imageWithLabel.snp.makeConstraints {
            $0.height.equalTo(view.frame.height / 2 - 40)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
