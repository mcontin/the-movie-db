//
//  MoviesListLayoutManager.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import UIKit

/// Protocol that encapsulates handling of the list of movies
protocol MoviesListLayoutManagerProtocol: UITableViewDelegate, UITableViewDataSource {
    var delegate: MoviesListDelegate? { get set }
    
    /// Call this function when you need to replace the list of movies
    ///
    /// - Parameter newMovies: the list of new movies
    func updateList(_ newMovies: [Movie])
}

/// Delegate responsible of handling interactions with the list
protocol MoviesListDelegate: AnyObject {
    func didSelect(movie: Movie)
}

/// Responsible for providing the data, layout and interaction with the list of movies
class MoviesListLayoutManager: NSObject, MoviesListLayoutManagerProtocol {
    
    fileprivate var movies: [Movie]
    
    weak var delegate: MoviesListDelegate?
    
    init(movies: [Movie] = []) {
        self.movies = movies
    }
    
    // MARK: - Data
    
    func updateList(_ newMovies: [Movie]) {
        self.movies = newMovies
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // MARK: - UI
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: MovieTableViewCell.self, indexPath: indexPath)
        
        cell.setup(with: movies[indexPath.row])
        
        return cell
    }
    
    // MARK: - Interaction
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(movie: movies[indexPath.row])
    }
    
}
