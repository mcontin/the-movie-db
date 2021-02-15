//
//  PosterUrlMapper.swift
//  TheMovieDB
//
//  Created by Mattia on 10/02/21.
//

import Foundation

/// Responsible for mapping posters/banners paths into fully usable URLs
class PosterUrlMapper {
    
    private let format: String
    
    static var small: PosterUrlMapper {
        PosterUrlMapper(format: "https://image.tmdb.org/t/p/w185%@")
    }
    
    static var big: PosterUrlMapper {
        PosterUrlMapper(format: "https://image.tmdb.org/t/p/w500%@")
    }
    
    init(format: String) {
        self.format = format
    }
    
    func map(from path: String?) -> URL? {
        guard let path = path else { return nil }
        
        let stringUrl = String(format: format, path)
        return URL(string: stringUrl)
    }
    
}
