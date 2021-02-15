//
//  MoviesListRepositoryProtocol.swift
//  TheMovieDB
//
//  Created by Mattia on 15/02/21.
//

import Foundation

protocol MoviesListRepositoryProtocol {
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
}
