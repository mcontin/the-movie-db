//
//  MovieResponse.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import Foundation

struct MovieResponse: Codable {
    let id: Int?
    let title: String?
    let backdropPath: String?
}
