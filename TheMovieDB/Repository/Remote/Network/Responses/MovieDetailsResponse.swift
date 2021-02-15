//
//  MovieDetailsResponse.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import Foundation

struct MovieDetailsResponse: Codable {
    let id: Int
    let title: String?
    let backdropPath: String?
    let overview: String?
}
