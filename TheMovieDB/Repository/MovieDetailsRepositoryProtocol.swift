//
//  MovieDetailsRepositoryProtocol.swift
//  TheMovieDB
//
//  Created by Mattia on 15/02/21.
//

import Foundation

protocol MovieDetailsRepositoryProtocol {
    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void)
}
