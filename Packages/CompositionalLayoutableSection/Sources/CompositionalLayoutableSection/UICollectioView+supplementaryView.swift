//
//  UICollectioView+supplementaryView.swift
//
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit

@available(iOS 13.0, *)
public extension UICollectionView {
    /**
     Registers a supplementary view class for a specific kind in the collection view.
     
     This method simplifies the process of registering a reusable supplementary view class with the collection view.
     It associates the provided class type with the given supplementary view kind
     and uses the class's identifier as the reuse identifier.
     
     - Parameters:
       - class: The class type of the supplementary view to register. This class must conform to `IdentifiableView`.
       - kind: The kind of supplementary view to associate with the class.
     */
    func register<T: UICollectionReusableView>(_ class: T.Type,
                                               supplementaryViewOfKind kind: String) where T: IdentifiableView {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }
    /// Register a UICollectionReusableView class from nib file with the collection view and associate it with a reuse identifier
    func registerFromNib<T: UICollectionReusableView>(_ class: T.Type,
                                                      supplementaryViewOfKind kind: String) where T: IdentifiableView {
        register(UINib(nibName: T.identifier, bundle: .main), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }
    /**
    Dequeues a reusable supplementary view of the specified class for a given kind and index path.
    
    This method simplifies the process of dequeuing a reusable supplementary view from the collection view
     . It dequeues a view of the provided class type for the specified supplementary view kind and index path.
     It's important that the class type is registered with the collection view using the
     `register(_:supplementaryViewOfKind:)` method before calling this method.
    
    - Parameters:
      - class: The class type of the supplementary view to dequeue. This class must conform to `IdentifiableView`.
      - kind: The kind of supplementary view being requested.
      - indexPath: The index path specifying the location of the supplementary view in the collection view.
    - Returns: A dequeued instance of the specified supplementary view class.
    - Precondition: The class type must be registered with the collection view using
     `register(_:supplementaryViewOfKind:)` before calling this method.
    */
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ class: T.Type,
                                                                       ofKind kind: String,
                                                                       for indexPath: IndexPath) -> T  where T: IdentifiableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: T.identifier,
                                                          for: indexPath) as? T else {
            fatalError(
            "Couldn't find UICollectionReusableView for \(T.identifier), make sure the view is registered with collection view")
        }
        return view
    }
}
