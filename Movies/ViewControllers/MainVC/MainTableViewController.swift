//
//  MainTableViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 19.05.2022.
//

import UIKit
import SnapKit

struct DumbMovie {
    let title: String?
    let image: UIImage?
}

class MainTableViewController: UIViewController {
    
    private let viewModel: UpcomingMovieListViewModel
    
    init(viewModel: UpcomingMovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var movieCategory: [String] = ["Today at the cinema", "Soon at the cinema", "Trending movies", "Top rated"]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SubCollectionViewHScrollCell.self, forCellReuseIdentifier: SubCollectionViewHScrollCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        return tableView
    }()
    
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

    private func fetchData() {
        viewModel.fetchData()
    }
    
    private func bindViewModelEvent() {
        
        viewModel.onFetchMovieSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onFetchMovieFailure = { error in
            print(error)
        }
    }
    
    private func setTitleAndBackground() {
        view.backgroundColor = .darkVioletBackgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        title = "Movies"
    }
    
    private func configureViews() {
        view.addSubview(tableView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}

extension MainTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        movieCategory.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        movieCategory[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            let label = UILabel()
            label.text = movieCategory[section]
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            
            let seeAllButton = UIButton()
            seeAllButton.setTitle("All", for: .normal)
            seeAllButton.setTitleColor(.orange, for: .normal)
            seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
            
            let stack = UIStackView()
                .axis(.horizontal)
                .distribution(.fillProportionally)
            [label, seeAllButton].forEach(stack.addArrangedSubview)
        header.addSubview(stack)
        stack.snp.makeConstraints{
            $0.edges.equalTo(header.snp.edges).inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubCollectionViewHScrollCell.identifier, for: indexPath) as! SubCollectionViewHScrollCell
        
        cell.bindWith(viewModel: viewModel)
        cell.backgroundColor = .clear
        cell.delegate = self
        return cell
    }
                 
    @objc private func seeAllButtonTapped() {
        let listOfMoviesVC = ListOfMoviesViewController(viewModel: viewModel, genres: movieCategory)
        self.navigationController?.pushViewController(listOfMoviesVC, animated: true)
    }
}

extension MainTableViewController: CollectionCellDelegate {
    func passIndexOfCollectionCell(collectionViewItemIndex: Int) {
        let detailsViewModel = UpcomingMovieDefaultViewModel.init(movie: viewModel.movies[collectionViewItemIndex])
        let movieVC = MovieDetailsViewController(viewModel: detailsViewModel, genre: ["adventure, crime, mystery"])
        self.navigationController?.pushViewController(movieVC, animated: true)
    }
}
