//
//  NetworkError.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import Foundation

enum NetworkError: Error {
    case unexpectedState
    case jsonDecodingFailure
    case serverError
}
