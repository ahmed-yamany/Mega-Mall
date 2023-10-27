//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 26/10/2023.
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

/// Extend the UICollectionView class with two helper methods
@available(iOS 13.0, *)
public extension UICollectionView {
    /// Register a cell class with the collection view and associate it with a reuse identifier
    func register<T: UICollectionViewCell>(_ class: T.Type) where T: IdentifiableView {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    /// Register a cell class from nib file with the collection view and associate it with a reuse identifier
    func registerFromNib<T: UICollectionViewCell>(_ class: T.Type) where T: IdentifiableView {
        register(UINib(nibName: T.identifier, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }
    /// Dequeue a reusable cell of a specified class from the collection view
    func dequeueReusableCell<T: UICollectionViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T where T: IdentifiableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            // swiftlint:disable all
            fatalError("Couldn't find UICollectionViewCell for \(T.identifier), make sure the cell is registered with collection view")
            // swiftlint:enable all
        }
        return cell
    }
}

extension UICollectionReusableView: IdentifiableView { }
