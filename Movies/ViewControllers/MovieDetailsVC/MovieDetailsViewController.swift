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
    
    init(movie: DumbMovie, genre: [String]) {
        super.init(nibName: nil, bundle: nil)
        guard let image = movie.image else { return }
        self.imageWithLabel = MovieCardView(.zero, of: image, with: 8.5)
        title = movie.title
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
    private var imageWithLabel: MovieCardView!
    
    lazy var movieTitleLabel = UILabel()
        .font(ofSize: 20, weight: .semibold)
        .textColor(.white)
        .text("Harry Potter")

    lazy var dateLabel = UILabel()
        .font(ofSize: 16, weight: .regular)
        .textColor(.white)
        .text("22-02-2022")
    
    lazy var movieDescriptionLabel: UITextView = {
        $0.isEditable = false
        $0.isScrollEnabled = true
        
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray
        $0.text = "Born on November 11, 1974, in Los Angeles, California, Leonardo Wilhelm DiCaprio is the only child of Irmelin and George DiCaprio. His parents divorced when he was still a toddler. DiCaprio was mostly raised by his mother, a legal secretary born in Germany. DiCaprio was mostly raised by his mother, a legal secretary born in Germany."
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
        
    }
    
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    private func configureView() {
        [imageWithLabel,
         movieTitleLabel,
         dateLabel,
         movieDescriptionLabel,
         castLalel,
         castCollectionView].forEach(movieVerticalStack.addArrangedSubview)
        
        [movieVerticalStack].forEach(scrollView.addSubview)
        
        view.addSubview(scrollView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    
        imageWithLabel.snp.makeConstraints {
            $0.height.equalTo(view.frame.height / 2 - 40)
//            $0.leading.equalTo(self.view.snp.leading)
//            $0.trailing.equalTo(self.view.snp.trailing)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        movieVerticalStack.snp.makeConstraints {
//            $0.leading.equalTo(self.view.snp.leading).offset(5)
//            $0.trailing.equalTo(self.view.snp.trailing).offset(-5)
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

