//
//  ListOfMoviesViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 20.05.2022.
//

import UIKit
import SnapKit

class ListOfMoviesViewController: UIViewController {
    
    private var model = [DumbMovie]()
    private var genres = ["Horror", "Adventure", "Drama", "Comedy", "Thriller", "Drama", "Comedy", "Thriller"]
    
    init(model: [DumbMovie], genres: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var genreCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    lazy var movieCardsTable: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieCardCell.self, forCellReuseIdentifier: MovieCardCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var mainVerticalStack = UIStackView()
        .axis(.vertical)
        .spacing(5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkVioletBackgroundColor
        setNavigationTitle()
        configureViews()
    }
    
    private func setNavigationTitle() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        title = "News"
    }

    private func configureViews() {
        [genreCollection, movieCardsTable].forEach(view.addSubview)
        makeConstraints()
    }
    
    private func makeConstraints() {
        genreCollection.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        movieCardsTable.snp.makeConstraints {
            $0.top.equalTo(genreCollection.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}

//MARK: TableVIew
extension ListOfMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCardCell.identifier, for: indexPath) as! MovieCardCell
        cell.configure(with: model[indexPath.row])
        cell.imgView.layer.cornerRadius = 15
        cell.imgView.clipsToBounds = true
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieVC = MovieDetailsViewController(movie: model[indexPath.row], genre: ["adventure, crime, mystery"])
        self.navigationController?.pushViewController(movieVC, animated: true)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

//MARK: CollectionView
extension ListOfMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
        cell.genreLabel.text = genres[indexPath.item]
        cell.genreLabel.sizeToFit()
        return cell
    }
}

extension ListOfMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = genres[indexPath.item]
        label.sizeToFit()
        return CGSize(width: label.frame.width, height: 30)
    }
}
