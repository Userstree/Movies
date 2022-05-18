//
//  MovieViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import UIKit
import SnapKit

class MovieViewController: UIViewController {
    
    private var imageWithLabel: MovieCardView!
    
    private lazy var commentsTableView: UITableView = {
        let table = UITableView()
        table.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    init(movie: Movie, genre: [String]) {
        super.init(nibName: nil, bundle: nil)
        guard let image = movie.image else { return }
        self.imageWithLabel = MovieCardView(.zero, of: image, with: 8.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        [imageWithLabel, commentsTableView].forEach(mainStack.addArrangedSubview)
        view.addSubview(mainStack)
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageWithLabel.snp.makeConstraints {
            $0.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height / 2 - 20)
        }
        
        mainStack.snp.makeConstraints {
            $0.edges.equalTo(self.view.snp.edges)
        }
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        
        return cell
    }
}
