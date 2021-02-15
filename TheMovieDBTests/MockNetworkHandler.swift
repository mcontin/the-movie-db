//
//  MockNetworkHandler.swift
//  TheMovieDBTests
//
//  Created by Mattia on 11/02/21.
//

import Foundation
@testable import TheMovieDB

class MockNetworkHandler: NetworkHandlerProtocol {
    
    let expectedMovies = [
        MovieResponse(id: 0, title: "First", backdropPath: nil),
        MovieResponse(id: 1, title: "Second", backdropPath: nil),
        MovieResponse(id: 2, title: "Third", backdropPath: nil),
        MovieResponse(id: 3, title: "Fourth", backdropPath: nil),
    ]
    
    lazy var moviesListResponse = MoviesListResponse(page: 1, results: expectedMovies, totalResults: 10, totalPages: 1)
    
    func getMovies(page: Int, completion: @escaping (Result<MoviesListResponse, Error>) -> Void) {
        completion(.success(moviesListResponse))
    }
    
    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void) {
        
    }
    
}
