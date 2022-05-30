//
//  HollyWoodActorViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 20.05.2022.
//

import UIKit

class HollyWoodActorViewController: UIViewController {
    
    private var model: ActorCast
    
    init(actor: ActorCast) {
        self.model = actor
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
        .text("22-02-1973")
    
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
    
    lazy var biographyDescrtiptionLabel: UITextView = {
        $0.isEditable = false
        $0.isScrollEnabled = false
        
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray
        $0.backgroundColor = .clear
        return $0
    }(UITextView())
    
    lazy var horizontalSubStack = UIStackView()
        .axis(.horizontal)
        .spacing(10)
    
    lazy var rightVerticalSubStack = UIStackView()
        .axis(.vertical)
        .distribution(.fillEqually)
        .spacing(4)
    
    lazy var mainVerticalStack = UIStackView()
        .axis(.vertical)
        .spacing(10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkVioletBackgroundColor
        configureViews()
        mapModel()
    }
    
    private func mapModel() {
        self.nameLabel.text = model.name
        self.departmentLabel.text = model.knownFor
        
    }

    private func configureViews() {
        [nameTitleLabel,
         nameLabel,
         birthdayTitleLabel,
         birthdayLabel,
         departmentTitleLabel,
         departmentLabel].forEach(rightVerticalSubStack.addArrangedSubview)
        
        [imageView, rightVerticalSubStack].forEach(horizontalSubStack.addArrangedSubview)
        
        [horizontalSubStack, biographyTitleLabel, biographyDescrtiptionLabel].forEach(mainVerticalStack.addArrangedSubview)
        
        view.addSubview(mainVerticalStack)
    
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        mainVerticalStack.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges).inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 125, height: 200))
        }
        
        biographyTitleLabel.snp.makeConstraints {
            $0.height.equalTo(25)
        }
    }
}
