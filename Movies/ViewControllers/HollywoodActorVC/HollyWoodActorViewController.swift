//
//  HollyWoodActorViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 20.05.2022.
//

import UIKit

class HollyWoodActorViewController: UIViewController {

    private var viewModel: PersonViewModel

    init(viewModel: PersonViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var nameTitleLabel = UILabel()
            .font(ofSize: 18, weight: .bold)
            .textColor(.white)
            .text("Name")

    lazy var nameLabel = UILabel()
            .font(ofSize: 16, weight: .regular)
            .textColor(.gray)

    lazy var birthdayTitleLabel = UILabel()
            .font(ofSize: 18, weight: .bold)
            .textColor(.white)
            .text("Birthday")

    lazy var birthdayLabel = UILabel()
            .font(ofSize: 16, weight: .regular)
            .textColor(.gray)
            .numberOfLines(2)

    lazy var departmentTitleLabel = UILabel()
            .font(ofSize: 18, weight: .bold)
            .textColor(.white)
            .text("Department")

    lazy var departmentLabel = UILabel()
            .font(ofSize: 16, weight: .regular)
            .textColor(.gray)

    lazy var biographyTitleLabel = UILabel()
            .font(ofSize: 18, weight: .bold)
            .textColor(.white)
            .text("Biography")

    lazy var biographyDescriptionLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    lazy var topHorizontalSubStack = UIStackView()
            .axis(.horizontal)
            .spacing(10)

    lazy var rightVerticalSubStack = UIStackView()
            .axis(.vertical)
            .distribution(.fillEqually)
            .spacing(4)

    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkVioletBackgroundColor
        configureViews()
        mapModel()
        bindWithPersonEvents()
    }

    private func bindWithPersonEvents() {
        viewModel.onFetchPersonSucceed = { [weak self] in
            self?.mapModel()
        }

        viewModel.onFetchPersonFailure = { error in
            print(error)
        }
    }

    private func mapModel() {
        guard let person = viewModel.person else {
            return
        }
        self.nameLabel.text = person.name
        self.departmentLabel.text = person.knownFor
        self.biographyDescriptionLabel.text = person.biography
        self.birthdayLabel.text = person.birthday
        viewModel.profileImage = { [weak self] image in
            guard let self = self else {
                return
            }
            self.imageView.image = image
        }
    }

    private func configureViews() {
        [nameTitleLabel,
         nameLabel,
         birthdayTitleLabel,
         birthdayLabel,
         departmentTitleLabel,
         departmentLabel].forEach(rightVerticalSubStack.addArrangedSubview)

        [imageView, rightVerticalSubStack].forEach(topHorizontalSubStack.addArrangedSubview)

        [topHorizontalSubStack, biographyTitleLabel, biographyDescriptionLabel].forEach(scrollView.addSubview)

        view.addSubview(scrollView)

        makeConstraints()
    }

    private func makeConstraints() {

        scrollView.snp.makeConstraints {

            $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges).offset(5)
            $0.bottom.equalTo(biographyDescriptionLabel.snp.bottom)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.size.equalTo(CGSize(width: 125, height: 200))
            $0.leading.equalTo(scrollView.snp.leading)
        }

        rightVerticalSubStack.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top)
            $0.trailing.equalTo(scrollView.snp.trailing)
            $0.height.equalTo(imageView.snp.height)
        }

        topHorizontalSubStack.snp.makeConstraints {
            $0.height.equalTo(imageView.snp.height)
            $0.top.equalTo(scrollView.snp.top)
            $0.width.equalTo(scrollView.snp.width)
            $0.leading.equalTo(scrollView.snp.leading)
        }

        biographyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.height.equalTo(25)
        }

        biographyDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(biographyTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.width.equalTo(scrollView.snp.width)
        }
    }
}
