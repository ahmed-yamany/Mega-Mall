//
//  CollectionViewModelSectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/02/2023.
//

import UIKit

public protocol CompositionalLayoutableSectionDataSource: UICollectionViewDataSource {
    /// A generic type representing the data type for the items in the section.
    associatedtype ItemsType
    /// An array of items for the section.
    var items: [ItemsType] { get set }
}
///
public extension CompositionalLayoutableSectionDataSource {
    /// updates items and should reloads collection view data
    func update(_ collectionView: UICollectionView, withItems items: [ItemsType]) {
        self.items = items
    }
}
//
@available(iOS 13.0, *)
@objc public protocol CompositionalLayoutableSectionLayout {
    /// Returns the layout for the section.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
}
//
@available(iOS 13.0, *)
public extension CompositionalLayoutableSectionLayout {
    /**
     Updates the pagination reusable view based on the current scroll offset and layout environment.
     
     - Parameters:
     - items: An array of `NSCollectionLayoutVisibleItem` representing the visible items in the collection view.
     - offset: The current content offset of the collection view.
     - layoutEnvironment: The `NSCollectionLayoutEnvironment` in which the collection view is being displayed.
     */
    func currentPageDidChanged(withItems items: [any NSCollectionLayoutVisibleItem],
                               offset: CGPoint,
                               layoutEnvironment: NSCollectionLayoutEnvironment, completion: (Int) -> Void) {
        let availableLayoutWidth = layoutEnvironment.container.effectiveContentSize.width
        // Calculate the current page based on the horizontal scroll offset and screen width
        let page = round(offset.x / availableLayoutWidth)
        // Call the method to update the pagination reusable view's selected page
        completion(Int(page))
    }
}
//
@available(iOS 13.0, *)
@objc public protocol CompositionalLayoutableSectionDelegate: UICollectionViewDelegate {
    /// Registers the cell type to be used for the items in the section.
    @objc func registerCell(_ collectionView: UICollectionView)
    /// Registers the supplementary view type to be used in the section.
    @objc optional func registerSupplementaryView(_ collectionView: UICollectionView)
    @objc optional func registerDecorationView(_ layout: UICollectionViewCompositionalLayout)
}

/*
 - This class defines a three optional properties that hold objects
   conforming to the three protocols a section in the compositional layout should implement

 - Using this can lead to better organization and abstraction of your code,
   as well as making it easier to reuse and maintain.
 
 - You can create multiple objects Inherets from this class
   and switch between them to show different sections in the same collection view,
 */

@available(iOS 13.0, *)
open class CompositionalLayoutableSection: NSObject {
    open var dataSource: (any CompositionalLayoutableSectionDataSource)?
    open var layout: (any CompositionalLayoutableSectionLayout)?
    open var delegate: (any CompositionalLayoutableSectionDelegate)?
}
