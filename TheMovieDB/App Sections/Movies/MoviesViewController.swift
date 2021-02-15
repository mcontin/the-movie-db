//
//  MoviesViewController.swift
//  TheMovieDB
//
//  Created by Mattia on 10/02/21.
//

import UIKit
import SnapKit

class MoviesViewController: UIViewController {
    
    // MARK: - Views
    
    private let moviesTableView = UITableView(frame: .zero)
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Dependencies
    
    private var logicController: MoviesLogicControllerProtocol
    private let moviesDataSource: MoviesListLayoutManagerProtocol
    private let coordinator: CoordinatorProtocol
    
    // MARK: - Lifecycle
    
    init(logicController: MoviesLogicControllerProtocol = MoviesLogicController(), moviesDataSource: MoviesListLayoutManagerProtocol = MoviesListLayoutManager(), coordinator: CoordinatorProtocol) {
        self.logicController = logicController
        self.coordinator = coordinator
        self.moviesDataSource = moviesDataSource
        
        super.init(nibName: nil, bundle: nil)
        
        self.moviesDataSource.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
        fetchMovies()
    }
    
    // MARK: - Prepare UI
    
    private func prepareView() {
        view.backgroundColor = .white
        view.addSubview(moviesTableView)
        navigationItem.title = "Movies"
        
        prepareTableView()
    }
    
    private func prepareTableView() {
        moviesTableView.register(MovieTableViewCell.self)
        moviesTableView.refreshControl = refreshControl
        moviesTableView.tableFooterView = UIView()
        moviesTableView.dataSource = moviesDataSource
        moviesTableView.delegate = moviesDataSource
        moviesTableView.estimatedRowHeight = 125
        
        refreshControl.addTarget(self, action: #selector(fetchMovies), for: .valueChanged)
        
        moviesTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    // MARK: - Data fetching
    
    @objc private func fetchMovies() {
        refreshControl.beginRefreshing()
        
        logicController.fetchMovies() { result in
            self.refreshControl.endRefreshing()
            
            switch result {
            case .success(let movies):
                self.moviesDataSource.updateList(movies)
                self.moviesTableView.reloadData()
            case .failure:
                let alert = UIAlertController(title: "Error",
                                              message: "There was an error loading the movies. Please retry.",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
                    self.fetchMovies()
                })
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                
                self.present(alert, animated: true)
            }
        }
    }
    
}

extension MoviesViewController: MoviesListDelegate {
    func didSelect(movie: Movie) {
        guard let id = movie.id else { return }
        coordinator.navigate(to: .movieDetails(movieId: id))
    }
}
