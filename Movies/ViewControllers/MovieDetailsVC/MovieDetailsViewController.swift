//
//  MovieViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var actorsModel = [HollywoodActor(image: UIImage(named: "BradPitt"), name: "Brad Pitt", role: "Smoking"),
                       HollywoodActor(image: UIImage(named: "DiCaprio"), name: "Leonardo DiCaprio", role: "Dancing"),
                       HollywoodActor(image: UIImage(named: "JasonMamoa"), name: "Jason Mamoa", role: "Throwing"),
                       HollywoodActor(image: UIImage(named: "TomHolland"), name: "Tom Holland", role: "Sleeping"),
                       HollywoodActor(image: UIImage(named: "RobertDowneyJr"), name: "Robert Downey Jr.", role: "Fying")]
    
    private var viewModel: UpcomingMovieViewModel
    
    init(viewModel: UpcomingMovieViewModel, genre: [String]) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    //>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var movieRatingLabel = UILabel()
            .backgroundColor(.orange)
            .textColor(.white)
            .font(ofSize: 14, weight: .semibold)
            .textAlignment(.center)
            .cornerRadius(12)
            .clipsToBounds(true)

    lazy var movieTitleLabel = UILabel()
        .font(ofSize: 20, weight: .semibold)
        .textColor(.white)

    lazy var dateLabel = UILabel()
        .font(ofSize: 16, weight: .regular)
        .textColor(.white)
        .text("22-02-2022")
    
    lazy var movieDescriptionLabel: UITextView = {
        $0.isEditable = false
        $0.isScrollEnabled = true
        
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray
        $0.text = viewModel.movie.overview
        $0.backgroundColor = .clear
        return $0
    }(UITextView())
    
    lazy private var movieVerticalStack = UIStackView()
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
        layout.itemSize = CGSize(width: 165, height: 165)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 500
        return layout
    }()
    
    lazy private var castCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(ActorCastCell.self, forCellWithReuseIdentifier: ActorCastCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkVioletBackgroundColor
        configureView()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 150)
        loadImageAndLabel()
        setData()
    }

    private func setData() {
        title = viewModel.movie.title
        self.movieTitleLabel.text = viewModel.movie.title
        self.dateLabel.text = viewModel.movie.releaseDate
    }

    private func loadImageAndLabel() {
        self.movieRatingLabel.text = "★\(viewModel.movie.rating)"
        self.movieRatingLabel.backgroundColor = viewModel.movie.ratingLabelColor.labelColor

        let imagePath = viewModel.movie.posterPath
        loadImage(path: imagePath) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let image):
                self.imageView.image = image
            case .failure(let error):
                print("Image for ImageDetails couldn't be loaded with ", error)
            }
        }
    }

    private func loadImage(path: String, completion: @escaping (Result<UIImage, ErrorResponse>) -> Void) {
        Task {
            let result = await ImageService.shared.fetchMovieImage(path: path)
            completion(result)
        }
    }

    //>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    private func configureView() {
        [imageView,
         movieTitleLabel,
         dateLabel,
         movieDescriptionLabel,
         castLalel,
         castCollectionView].forEach(movieVerticalStack.addArrangedSubview)
        
        [movieVerticalStack, movieRatingLabel].forEach(scrollView.addSubview)
        
        view.addSubview(scrollView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    
        imageView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.height.equalTo(view.frame.height / 2 - 40)
            $0.centerX.equalTo(view.snp.centerX)
        }

        movieRatingLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading).offset(20)
            $0.top.equalTo(imageView.snp.top).offset(20)
            $0.size.equalTo(CGSize(width: 60, height: 25))
        }

        movieVerticalStack.snp.makeConstraints {
            $0.height.equalTo(800)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.equalTo(self.movieVerticalStack.snp.leading)
        }
        
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.equalTo(self.movieVerticalStack.snp.leading)
        }
        
        movieDescriptionLabel.snp.makeConstraints {
            $0.width.equalTo(self.view.snp.width)
        }
        
        castLalel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.equalTo(self.movieVerticalStack.snp.leading)
        }
        
        castCollectionView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: self.view.frame.width - 10, height: 180))
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(5)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-5)
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actorVC = HollyWoodActorViewController(actor: actorsModel[indexPath.item])
        self.navigationController?.pushViewController(actorVC, animated: true)
    }
}

