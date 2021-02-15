//
//  MoviesListResponse.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import Foundation

struct MoviesListResponse: Codable {
    let page: Int?
    let results: [MovieResponse]
    let totalResults: Int?
    let totalPages: Int?
}
