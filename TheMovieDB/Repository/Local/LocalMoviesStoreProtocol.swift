//
//  LocalMoviesStoreProtocol.swift
//  TheMovieDB
//
//  Created by Mattia on 15/02/21.
//

import Foundation

enum LocalStoreError: Error {
    case notFound
}

protocol LocalMoviesStoreProtocol {
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void)
    
    func store(movies: [Movie], pageLocation: Int)
    func store(movieDetails: MovieDetails)
}
