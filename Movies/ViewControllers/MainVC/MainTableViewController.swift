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
    
    private var movieCategory: [String] = ["Today at the cinema", "Soon at the cinema", "Trending movies", "Top rated"]
    
    private var movieSet = [DumbMovie(title: "Horse", image: UIImage(named: "Horse")),
                            DumbMovie(title: "Harry Potter", image: UIImage(named: "Harry Potter"))]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SubCollectionViewCell.self, forCellReuseIdentifier: SubCollectionViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleAndBackground()
        configureViews()
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
        return movieCategory.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movieCategory[section]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SubCollectionViewCell.identifier, for: indexPath) as! SubCollectionViewCell

        cell.configure(with: movieSet)
        cell.backgroundColor = .clear
        cell.delegate = self
        return cell
    }
    
    @objc private func seeAllButtonTapped() {
        let listOfMoviesVC = ListOfMoviesViewController(model: movieSet, genres: movieCategory)
        self.navigationController?.pushViewController(listOfMoviesVC, animated: true)
    }
}

extension MainTableViewController: CollectionCellDelegate {
    func passIndexOfCollectionCell(collectionViewItemIndex: Int) {
        let movieVC = MovieDetailsViewController(movie: movieSet[collectionViewItemIndex], genre: ["adventure, crime, mystery"])
        self.navigationController?.pushViewController(movieVC, animated: true)
    }
}
