//
//  MovieDetails.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import Foundation

struct MovieDetails: Hashable {
    let id: Int
    let bannerUrl: URL?
    let title: String?
    let overview: String?
}
