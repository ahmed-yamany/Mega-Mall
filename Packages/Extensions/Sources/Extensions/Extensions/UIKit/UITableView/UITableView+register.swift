//
//  UITableView+register.swift
//
//  Created by Ahmed Yamany on 04/11/2023.
//

import UIKit

/// A Protocol that defines a reusable identifer for any view conforms to it
@available(iOS 13.0, *)
public protocol IdentifiableView: Identifiable {
}

@available(iOS 13.0, *)
public extension IdentifiableView where Self: UIView {
    /// Get the reuse identifier for the cell by using the class name
    static var identifier: String {
        return String(describing: self)
    }
}

@available(iOS 13.0, *)
public extension UITableView {
    /// Register a cell class with the TableView and associate it with a reuse identifier
    func register<T: UITableViewCell>(_ class: T.Type) where T: IdentifiableView {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    /// Register a cell class from nib file with the TableView and associate it with a reuse identifier
    func registerFromNib<T: UITableViewCell>(_ class: T.Type) where T: IdentifiableView {
        register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
    /// Dequeue a reusable cell of a specified class from the TableView
    func dequeueReusableCell<T: UITableViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T where T: IdentifiableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError(
                "Couldn't find UITableView for \(T.identifier), make sure the cell is registered with collection view")
        }
        return cell
    }
}

extension UITableViewCell: IdentifiableView {}
