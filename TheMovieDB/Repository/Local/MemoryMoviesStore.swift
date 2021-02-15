//
//  MemoryMoviesStore.swift
//  TheMovieDB
//
//  Created by Mattia on 15/02/21.
//

import Foundation

class MemoryMoviesStore: LocalMoviesStoreProtocol {
    
    static let shared = MemoryMoviesStore()
    
    private var cachedMovies = [Int: [Movie]]()
    private var cachedMovieDetails = Set<MovieDetails>()
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        if let movies = cachedMovies[page] {
            completion(.success(movies))
        } else {
            completion(.failure(LocalStoreError.notFound))
        }
    }
    
    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        if let details = cachedMovieDetails.first(where: { $0.id == movieId }) {
            completion(.success(details))
        } else {
            completion(.failure(LocalStoreError.notFound))
        }
    }
    
    func store(movies: [Movie], pageLocation: Int) {
        if movies.count > 0 {
            cachedMovies[pageLocation] = movies
        }
    }
    
    func store(movieDetails: MovieDetails) {
        cachedMovieDetails.insert(movieDetails)
    }
    
}
