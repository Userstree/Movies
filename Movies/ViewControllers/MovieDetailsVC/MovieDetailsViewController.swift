//
//  MovieViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var actorsModel = [HollywoodActor(image: UIImage(named: "BradPitt"), name: "BradPitt", role: "Smoking"),
                       HollywoodActor(image: UIImage(named: "DiCaprio"), name: "Leonardo DiCaprio", role: "Dancing"),
                       HollywoodActor(image: UIImage(named: "JasonMamoa"), name: "Jason Mamoa", role: "Throwing"),
                       HollywoodActor(image: UIImage(named: "TomHolland"), name: "Tom Holland", role: "Sleeping"),
                       HollywoodActor(image: UIImage(named: "RobertDowneyJr"), name: "Robert Downey Jr.", role: "Fying")]
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    //>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<
    private var imageWithLabel: MovieCardView!
    
    lazy var movieTitleLabel = UILabel()
        .font(ofSize: 18, weight: .semibold)
        .textColor(.white)
        .text("Harry Potter")

    lazy var dateLabel = UILabel()
        .font(ofSize: 14, weight: .regular)
        .textColor(.white)
        .text("22-02-2022")
    
    lazy var movieDescriptionLabel = UILabel()
        .textColor(.white)
        .numberOfLines(0)
        .textAlignment(.left)
        .text("apufv pafjv apjfbv pajbfvpab fhv ajfbvandvaf va ivajdnvj djdajsd oavh pbajbja bafhv jbdjva fvh")
    
    lazy private var movieStack = UIStackView()
        .axis(.vertical)
        .spacing(0)
        .alignment(.leading)
    
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    lazy var castLalel = UILabel()
        .text("Cast")
        .font(ofSize: 18, weight: .semibold)
        .textColor(.white)
        .textAlignment(.left)
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 35
        layout.minimumInteritemSpacing = 200
        return layout
    }()
    
    lazy private var castCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(ActorCastCell.self, forCellWithReuseIdentifier: ActorCastCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 150)
        
    }
    
    init(movie: DumbMovie, genre: [String]) {
        super.init(nibName: nil, bundle: nil)
        guard let image = movie.image else { return }
        self.imageWithLabel = MovieCardView(.zero, of: image, with: 8.5)
        title = movie.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    private func configureView() {
        [imageWithLabel, movieTitleLabel, dateLabel, movieDescriptionLabel, castLalel, castCollectionView].forEach(movieStack.addArrangedSubview)
        [movieStack].forEach(scrollView.addSubview)
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
        
        movieStack.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.height.equalTo(800)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.width.equalTo(self.view.snp.width)
        }
        
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.width.equalTo(self.view.snp.width)
        }
        
        movieDescriptionLabel.snp.makeConstraints {
            $0.width.equalTo(self.view.snp.width)
        }
        
        castLalel.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.width.equalTo(self.view.snp.width)
        }
        
        castCollectionView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: self.view.frame.width, height: 230))
        }
        
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actorsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCastCell.identifier, for: indexPath) as! ActorCastCell
        cell.configure(with: actorsModel[indexPath.item])
        cell.imgView.layer.cornerRadius = cell.frame.height / 2
        cell.imgView.clipsToBounds = true
        cell.backgroundColor = .gray
        return cell
    }
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 155, height: 165)
    }
}
