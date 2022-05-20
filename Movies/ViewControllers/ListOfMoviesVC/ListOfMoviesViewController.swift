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
    
    private lazy var mainStack = UIStackView()
        .axis(.vertical)
        .spacing(5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkVioletBackgroundColor
        setNavigationTitle()
        configureViews()
    }
    
    init(model: [DumbMovie], genres: [String]) {
        super.init(nibName: nil, bundle: nil)
//        self.genres = genres
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavigationTitle() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        title = "News"
    }

    private func configureViews() {
        [genreCollection, movieCardsTable].forEach(mainStack.addArrangedSubview)
        view.addSubview(mainStack)
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainStack.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        genreCollection.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: view.frame.width - 20, height: 40))
            $0.centerX.equalTo(mainStack.snp.centerX)
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
        300
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
