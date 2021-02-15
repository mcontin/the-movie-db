//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Mattia on 10/02/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Views
    
    private let imageView = UIImageView()
    private let movieTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    // MARK: - Dependencies
    
    private let logicController: MovieDetailLogicControllerProtocol
    private let coordinator: CoordinatorProtocol
    
    // MARK: - Lifecycle
    
    init(logicController: MovieDetailLogicControllerProtocol, coordinator: CoordinatorProtocol) {
        self.logicController = logicController
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
        fetchMovieDetails()
    }
    
    // MARK: - Prepare UI
    
    private func prepareView() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(movieTitleLabel)
        view.addSubview(descriptionLabel)
        
        prepareImageView()
        prepareTitleLabel()
        prepareDescriptionLabel()
    }
    
    private func prepareImageView() {
        imageView.contentMode = .scaleAspectFill
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(280)
        }
    }
    
    private func prepareTitleLabel() {
        movieTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func prepareDescriptionLabel() {
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Data fetching
    
    private func fetchMovieDetails() {
        logicController.fetchDetails { result in
            switch result {
            case .success(let details):
                self.imageView.sd_setImage(with: details.bannerUrl)
                self.movieTitleLabel.text = details.title
                self.descriptionLabel.text = details.overview
            case .failure:
                let alert = UIAlertController(title: "Error",
                                              message: "There was an error loading the movie details. Please retry.",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                    self.coordinator.back()
                })
            
                self.present(alert, animated: true)
            }
        }
    }
    
}
