//
//  UICollectionView+SectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/02/2023.
//

import UIKit

@available(iOS 13.0, *)
extension UICollectionView {
    /**
     Updates the collection view's compositional layout using the provided `CompositionalLayoutProvider`.
     
     This method takes a `CompositionalLayoutProvider` as a parameter
     and uses it to update the collection view's compositional layout.
     It also handles the registration of cells and supplementary views defined by the `CompositionalLayoutProvider`.
     
     - Parameter provider: The `CompositionalLayoutProvider` object
     that configures the layout and registers cells and supplementary views.
     
     - Note: Before calling `updateCollectionViewCompositionalLayout(with:)`,
     ensure that the sections for the compositional layout have been appended to the `compositionalLayoutSections`
     property of the `CompositionalLayoutProvider`.
     Calling this method before configuring the sections may lead to unexpected behavior.
     
     Example usage:
        ```swift
        // Appdate collection View Delegate
        compositionalLayoutDelegate.updateProvider(with: self)
        compositionalLayoutDataSource.updateProvider(with: self)
        collectionView.delegate = compositionalLayoutDelegate
        collectionView.dataSource = compositionalLayoutDataSource
        // Append sections compositionalLayoutSections...
        let section = SplashCollectionViewSection()
        compositionalLayoutSections.append(section)
        section.update(collectionView, withItems: [])
        // Then call this method
        collectionView.updateCollectionViewCompositionalLayout(with: layoutProvider)
     */
    public func updateCollectionViewCompositionalLayout(for provider: CompositionalLayoutProvider) {
        // Register cells and supplementary views defined by the provider
        provider.registerCells(for: self)
        provider.registerSupplementaryViews(for: self)
        // Apply the compositional layout from the provider to the collection view
        collectionViewLayout = provider.collectionViewCompositionalLayout
        reloadData()
    }
}
