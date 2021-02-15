//
//  MoviesViewControllerBuilder.swift
//  TheMovieDB
//
//  Created by Mattia on 10/02/21.
//

import Foundation

class MoviesViewControllerBuilder {
    
    static func build(with coordinator: CoordinatorProtocol) -> MoviesViewController {
        return MoviesViewController(coordinator: coordinator)
    }
    
}
