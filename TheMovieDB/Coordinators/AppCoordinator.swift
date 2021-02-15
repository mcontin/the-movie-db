//
//  AppCoordinator.swift
//  TheMovieDB
//
//  Created by Mattia on 10/02/21.
//

import UIKit

enum AppSection {
    case moviesList
    case movieDetails(movieId: Int)
}

class AppCoordinator: CoordinatorProtocol {
    
    static let shared = AppCoordinator()
    
    let rootController: UINavigationController
    
    init(root: UINavigationController = UINavigationController()) {
        self.rootController = root
    }
    
    func start() {
        navigate(to: .moviesList)
    }
    
    func navigate(to section: AppSection) {
        switch section {
        case .moviesList:
            let listViewController = MoviesViewControllerBuilder.build(with: self)
            rootController.pushViewController(listViewController, animated: true)
        case .movieDetails(let movieId):
            let detailsViewController = MovieDetailBuilder.build(with: movieId, coordinator: self)
            rootController.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func back() {
        rootController.popViewController(animated: true)
    }
    
}
