//
//  MoviesLogicController.swift
//  TheMovieDB
//
//  Created by Mattia on 10/02/21.
//

import Foundation
import UIKit

/// Protocol to be implemented by classes that will handle business logic in the movies list
protocol MoviesLogicControllerProtocol {
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MoviesLogicController: MoviesLogicControllerProtocol {
    
    // MARK: - Dependencies
    
    private let networkHandler: MoviesListRepositoryProtocol
    
    init(networkHandler: MoviesListRepositoryProtocol = MoviesRepository()) {
        self.networkHandler = networkHandler
    }
    
    // MARK: - Business logic
    
    /// Fetches movies using the network handler, maps in a background thread and delivers
    /// the result using the passed closure.
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        networkHandler.getMovies(page: 1) { result in
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
