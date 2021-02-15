//
//  DequeueableCell.swift
//  quiXmatch
//
//  Created by Mattia on 10/02/21.
//

import Foundation

import UIKit

protocol DequeueableCell: class {
    static var reuseIdentifier: String { get }
}

extension DequeueableCell where Self: UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableView {
    
    func register<T: DequeueableCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: DequeueableCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cell \(T.reuseIdentifier) is not registered.")
        }
        return cell
    }
    
}
