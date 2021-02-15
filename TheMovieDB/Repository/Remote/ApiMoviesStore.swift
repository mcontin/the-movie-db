//
//  ApiMoviesStore.swift
//  TheMovieDB
//
//  Created by Mattia on 15/02/21.
//

import Foundation

class ApiMoviesStore: RemoteMoviesStoreProtocol {
    
    private let networkHandler: NetworkHandlerProtocol
    
    init(networkHandler: NetworkHandlerProtocol = NetworkHandler.shared) {
        self.networkHandler = networkHandler
    }

    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        self.networkHandler.getMovies(page: page) { result in
            switch result {
            case .success(let response):
                DispatchQueue.global().async {
                    let movies = MovieMapper().movies(from: response.results)
                    DispatchQueue.main.async {
                        completion(.success(movies))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        self.networkHandler.getMovieDetails(movieId: movieId) { result in
            switch result {
            case .success(let response):
                DispatchQueue.global().async {
                    let details = MovieMapper().movieDetails(from: response)
                    DispatchQueue.main.async {
                        completion(.success(details))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
