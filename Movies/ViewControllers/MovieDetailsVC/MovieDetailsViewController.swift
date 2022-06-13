//
//  MovieViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 18.05.2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    private var viewModel: MovieViewModel
    {
        didSet {
            castCollectionView.reloadData()
        }
    }

    init(viewModel: MovieViewModel) {
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

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
            .numberOfLines(0)
            .font(ofSize: 20, weight: .semibold)
            .textColor(.white)

    lazy var dateLabel = UILabel()
            .font(ofSize: 16, weight: .regular)
            .textColor(.white)

    lazy var movieDescriptionLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray
        $0.text = viewModel.movie.overview
        $0.backgroundColor = .clear
        return $0
    }(UILabel())

    /*>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
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
        loadImageAndLabel()
        setData()
    }

    private func setData() {
        title = viewModel.movie.title
        movieTitleLabel.text = viewModel.movie.title
        dateLabel.text = viewModel.movie.releaseDate
    }

    private func loadImageAndLabel() {
        movieRatingLabel.text = "★\(viewModel.movie.rating)"
        movieRatingLabel.backgroundColor = viewModel.movie.ratingLabelColor.labelColor

        viewModel.fetchImage(posterPath: viewModel.movie.posterPath) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let image):
                self.imageView.image = image
            case .failure(let error):
                print("Image for ImageDetails couldn't be loaded with ", error)
            }
        }
    }

    //>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    private func configureView() {

        [imageView,
         movieTitleLabel,
         dateLabel,
         movieDescriptionLabel,
         castLalel,
         castCollectionView,
         movieRatingLabel].forEach(scrollView.addSubview)

        view.addSubview(scrollView)

        makeConstraints()
    }

    private func makeConstraints() {

        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges).offset(5)
            $0.bottom.equalTo(castCollectionView.snp.bottom)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.centerX.equalTo(view.snp.centerX)
            $0.leading.equalTo(scrollView.snp.leading)
        }

        movieRatingLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading).offset(20)
            $0.top.equalTo(imageView.snp.top).offset(20)
            $0.size.equalTo(CGSize(width: 60, height: 25))
        }

        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(150)
            $0.width.equalTo(scrollView.snp.width)
            $0.leading.equalTo(scrollView.snp.leading)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(10)
            $0.width.equalTo(scrollView.snp.width)
            $0.leading.equalTo(scrollView.snp.leading)
        }

        movieDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.width.equalTo(view.snp.width)
            $0.leading.equalTo(scrollView.snp.leading)
        }

        castLalel.snp.makeConstraints {
            $0.top.equalTo(movieDescriptionLabel.snp.bottom)
            $0.height.equalTo(40)
            $0.leading.equalTo(scrollView.snp.leading)
        }

        castCollectionView.snp.makeConstraints {
            $0.top.equalTo(castLalel.snp.bottom).offset(10)
            $0.size.equalTo(CGSize(width: view.frame.width - 10, height: 180))
        }
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.castOfActors.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCastCell.identifier, for: indexPath) as! ActorCastCell

        cell.configure(with: viewModel.castOfActors.value[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.castOfActors.bindAndFire { casts in
            let actorVC = HollyWoodActorViewController(viewModel: DefaultPersonViewModel(personID: casts[indexPath.item].id))
            self.navigationController?.pushViewController(actorVC, animated: true)
            collectionView.reloadData()
        }
    }
}

