//
//  RemoteMoviesStoreProtocol.swift
//  TheMovieDB
//
//  Created by Mattia on 15/02/21.
//

import Foundation

protocol RemoteMoviesStoreProtocol {
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void)
}
