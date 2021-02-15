//
//  MockMoviesListRepository.swift
//  TheMovieDBTests
//
//  Created by Mattia on 15/02/21.
//

import Foundation
@testable import TheMovieDB

class MockRemoteMoviesStore: RemoteMoviesStoreProtocol {
    
    let expectedMovies = [
        MovieResponse(id: 0, title: "First", backdropPath: nil),
        MovieResponse(id: 1, title: "Second", backdropPath: nil),
        MovieResponse(id: 2, title: "Third", backdropPath: nil),
        MovieResponse(id: 3, title: "Fourth", backdropPath: nil),
    ]
    
    lazy var moviesListResponse = MoviesListResponse(page: 1, results: expectedMovies, totalResults: 10, totalPages: 1)
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let movies = MovieMapper().movies(from: moviesListResponse.results)
        completion(.success(movies))
    }

    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        
    }
    
}
