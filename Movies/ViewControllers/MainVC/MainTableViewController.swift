//
//  MainTableViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 19.05.2022.
//

import UIKit
import SnapKit

class MainTableViewController: UIViewController {

    // MARK: - Vars & Lets

    private var viewModel: MoviesListViewModel {
        didSet {
            tableView.reloadData()
        }
    }

    private var categoriesList: [MoviesListEndpoint] = [MoviesListEndpoint.nowPlaying,
                                                        MoviesListEndpoint.upcoming,
                                                        MoviesListEndpoint.topRated,
                                                        MoviesListEndpoint.popular,
    ]

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MoviesListCollectionViewHScrollCell.self, forCellReuseIdentifier: MoviesListCollectionViewHScrollCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        return tableView
    }()

    // MARK: - Controller lifecycle

    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.barStyle = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitleAndBackground()
        configureViews()
        fetchData()
    }

    // MARK: - Private methods

    private func fetchData() {
        viewModel.fetchData()
    }

    private func setTitleAndBackground() {
        view.backgroundColor = .darkVioletBackgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Movies"
    }

    // MARK: - Configuration of the View

    private func configureViews() {
        view.addSubview(tableView)
        makeConstraints()
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }

    // MARK: - Init

    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UITableViewDelegate

extension MainTableViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource

extension MainTableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        categoriesList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        categoriesList[section].rawValue
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        label.text = categoriesList[section].rawValue
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        let seeAllButton = UIButton()
        seeAllButton.setTitle("All", for: .normal)
        seeAllButton.setTitleColor(.orange, for: .normal)
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped(_:)), for: .touchUpInside)
        seeAllButton.tag = section

        let stack = UIStackView()
                .axis(.horizontal)
                .distribution(.fillProportionally)
        [label, seeAllButton].forEach(stack.addArrangedSubview)
        header.addSubview(stack)
        stack.snp.makeConstraints {
            $0.edges.equalTo(header.snp.edges).inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        }
        return header
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesListCollectionViewHScrollCell.identifier, for: indexPath) as! MoviesListCollectionViewHScrollCell
        switch categoriesList[indexPath.section] {
        case .upcoming:
            viewModel.upcomingMovies.bindAndFire {
                cell.bindWith(models: $0, sectionNumber: indexPath.section)
            }
        case .nowPlaying:
            viewModel.todayMovies.bindAndFire {
                cell.bindWith(models: $0, sectionNumber: indexPath.section)
            }
        case .topRated:
            viewModel.topRatedMovies.bindAndFire {
                cell.bindWith(models: $0, sectionNumber: indexPath.section)
            }
        case .popular:
            viewModel.popularMovies.bindAndFire {
                cell.bindWith(models: $0, sectionNumber: indexPath.section)
            }
        }
        cell.backgroundColor = .clear
        cell.delegate = self
        return cell
    }

    @objc private func seeAllButtonTapped(_ sender: UIButton) {
        switch categoriesList[sender.tag] {
        case .upcoming:
            let listOfMoviesVC = ListOfMoviesViewController(movies: viewModel.upcomingMovies.value, genres: viewModel.allGenres.value)
            navigationController?.pushViewController(listOfMoviesVC, animated: true)
        case .nowPlaying:
            let listOfMoviesVC = ListOfMoviesViewController(movies: viewModel.todayMovies.value, genres: viewModel.allGenres.value)
            navigationController?.pushViewController(listOfMoviesVC, animated: true)
        case .topRated:
            let listOfMoviesVC = ListOfMoviesViewController(movies: viewModel.topRatedMovies.value, genres: viewModel.allGenres.value)
            navigationController?.pushViewController(listOfMoviesVC, animated: true)
        case .popular:
            let listOfMoviesVC = ListOfMoviesViewController(movies: viewModel.popularMovies.value, genres: viewModel.allGenres.value)
            navigationController?.pushViewController(listOfMoviesVC, animated: true)
        }
    }
}

// MARK: - CollectionCellDelegate

extension MainTableViewController: CollectionCellDelegate {
    func passIndexOfCollectionCell(collectionViewItemIndex: Int, categoryNumber: Int) {
        switch categoriesList[categoryNumber] {
        case .nowPlaying:
            let detailsViewModel = DefaultMovieViewModel.init(movie: viewModel.todayMovies.value[collectionViewItemIndex])
            let movieVC = MovieDetailsViewController(viewModel: detailsViewModel)
            navigationController?.pushViewController(movieVC, animated: true)
        case .upcoming:
            let detailsViewModel = DefaultMovieViewModel.init(movie: viewModel.upcomingMovies.value[collectionViewItemIndex])
            let movieVC = MovieDetailsViewController(viewModel: detailsViewModel)
            navigationController?.pushViewController(movieVC, animated: true)
        case .topRated:
            let detailsViewModel = DefaultMovieViewModel.init(movie: viewModel.topRatedMovies.value[collectionViewItemIndex])
            let movieVC = MovieDetailsViewController(viewModel: detailsViewModel)
            navigationController?.pushViewController(movieVC, animated: true)
        case .popular:
            let detailsViewModel = DefaultMovieViewModel.init(movie: viewModel.popularMovies.value[collectionViewItemIndex])
            let movieVC = MovieDetailsViewController(viewModel: detailsViewModel)
            navigationController?.pushViewController(movieVC, animated: true)
        }
    }
}
