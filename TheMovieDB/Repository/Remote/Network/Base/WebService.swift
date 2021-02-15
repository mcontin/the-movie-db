//
//  WebService.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import Foundation

enum HttpMethod: String {
    case get, post, put, delete, patch
}

protocol WebService {
    var endpoint: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var query: String? { get }
}
