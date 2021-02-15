//
//  MovieDetailLogicController.swift
//  TheMovieDB
//
//  Created by Mattia on 10/02/21.
//

import Foundation

/// Protocol to be implemented by classes that will handle business logic in the movie details
protocol MovieDetailLogicControllerProtocol {
    func fetchDetails(completion: @escaping (Result<MovieDetails, Error>) -> Void)
}

class MovieDetailLogicController: MovieDetailLogicControllerProtocol {
    
    // MARK: - Dependencies
    
    private let networkHandler: MovieDetailsRepositoryProtocol
    private let movieMapper: MovieMapperProtocol
    
    private let movieId: Int
    
    init(movieId: Int, networkHandler: MovieDetailsRepositoryProtocol = MoviesRepository(), mapper: MovieMapperProtocol = MovieMapper()) {
        self.movieId = movieId
        self.networkHandler = networkHandler
        self.movieMapper = mapper
    }
    
    // MARK: - Business logic
    
    func fetchDetails(completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        networkHandler.getMovieDetails(movieId: movieId) { result in
            switch result {
            case .success(let details):
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
