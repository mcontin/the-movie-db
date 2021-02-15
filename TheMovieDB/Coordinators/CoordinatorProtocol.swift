//
//  CoordinatorProtocol.swift
//  TheMovieDB
//
//  Created by Mattia on 10/02/21.
//

import Foundation

protocol CoordinatorProtocol: AnyObject {
    func start()
    func navigate(to section: AppSection)
    func back()
}
