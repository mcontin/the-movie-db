//
//  MovieDetailBuilder.swift
//  TheMovieDB
//
//  Created by Mattia on 10/02/21.
//

import Foundation

class MovieDetailBuilder {
    
    static func build(with movieId: Int, coordinator: CoordinatorProtocol) -> MovieDetailViewController {
        let detailsLogic = MovieDetailLogicController(movieId: movieId)
        let detailsViewController = MovieDetailViewController(logicController: detailsLogic, coordinator: coordinator)
        return detailsViewController
    }
    
}
