//
//  MoviesService.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import Foundation

enum MoviesService: WebService {
    
    // MARK: - Usable endpoints
    
    case getMovies
    case getMovieDetails(movieId: Int)

    // MARK: - Properties used to build requests
    
    var endpoint: String {
        switch self {
        case .getMovies:
            return "/movie/popular"
        case .getMovieDetails(let movieId):
            return "/movie/\(movieId)"
        }
    }
    
    var query: String? {
        fatalError("return api_key={KEY}")
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
}
