//
//  MovieMapper.swift
//  TheMovieDB
//
//  Created by Mattia on 11/02/21.
//

import Foundation

protocol MovieMapperProtocol {
    func movie(from response: MovieResponse) -> Movie
    func movies(from responses: [MovieResponse]) -> [Movie]
    func movieDetails(from response: MovieDetailsResponse) -> MovieDetails
}

/// Responsible for mapping API responses into models
class MovieMapper: MovieMapperProtocol {
    
    func movie(from response: MovieResponse) -> Movie {
        return Movie(id: response.id,
                     title: response.title,
                     bannerUrl: PosterUrlMapper.small.map(from: response.backdropPath))
    }
    
    func movies(from responses: [MovieResponse]) -> [Movie] {
        let urlMapper = PosterUrlMapper.small
        return responses.map {
            Movie(id: $0.id,
                  title: $0.title,
                  bannerUrl: urlMapper.map(from: $0.backdropPath))
        }
    }
    
    func movieDetails(from response: MovieDetailsResponse) -> MovieDetails {
        return MovieDetails(id: response.id,
                            bannerUrl: PosterUrlMapper.big.map(from: response.backdropPath),
                            title: response.title,
                            overview: response.overview)
    }
    
}
