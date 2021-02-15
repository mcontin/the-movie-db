//
//  Movie.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import Foundation

struct Movie {
    let id: Int?
    let title: String?
    let bannerUrl: URL?
}

extension Movie: Equatable { }
