//
//  MoviesRepository.swift
//  TheMovieDB
//
//  Created by Mattia on 15/02/21.
//

import Foundation

typealias MoviesRepositoryProtocol = MoviesListRepositoryProtocol & MovieDetailsRepositoryProtocol

class MoviesRepository: MoviesRepositoryProtocol {
    
    private let localStore: LocalMoviesStoreProtocol
    private let remoteStore: RemoteMoviesStoreProtocol
    
    init(localStore: LocalMoviesStoreProtocol = MemoryMoviesStore.shared, remoteStore: RemoteMoviesStoreProtocol = ApiMoviesStore()) {
        self.localStore = localStore
        self.remoteStore = remoteStore
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        localStore.getMovies(page: page) { result in
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure:
                self.remoteStore.getMovies(page: page) { result in
                    switch result {
                    case .success(let movies):
                        self.localStore.store(movies: movies, pageLocation: page)
                        completion(.success(movies))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        localStore.getMovieDetails(movieId: movieId) { result in
            switch result {
            case .success(let details):
                completion(.success(details))
            case .failure(_):
                self.remoteStore.getMovieDetails(movieId: movieId) { result in
                    switch result {
                    case .success(let details):
                        self.localStore.store(movieDetails: details)
                        completion(.success(details))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
}
