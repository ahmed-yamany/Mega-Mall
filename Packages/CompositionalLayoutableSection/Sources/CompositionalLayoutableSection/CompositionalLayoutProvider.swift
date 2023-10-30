//
//  UICollectionViewCompositionalLayoutProvider.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit

/// Protocol that defines the requirements for providing data for a compositional layout in a collection view
@available(iOS 13.0, *)
public protocol CompositionalLayoutProvider {
    /// An array of compositional layout sections to be used in the collection view's layout
    var compositionalLayoutSections: [CompositionalLayoutableSection] { get set }
}

@available(iOS 13.0, *)
extension CompositionalLayoutProvider {
    /// Registers cells for all sections in the collection view
    public func registerCells(for collectionView: UICollectionView) {
        compositionalLayoutSections.forEach { $0.delegate?.registerCell(collectionView) }
    }
    /// Registers supplementary views for all sections in the collection view
    public func registerSupplementaryViews(for collectionView: UICollectionView) {
        compositionalLayoutSections.forEach { $0.delegate?.registerSupplementaryView?(collectionView) }
    }
    /// Registers Decoration Views for all section in the collection View
    private func registerDecorationViews(for layout: UICollectionViewCompositionalLayout) {
        compositionalLayoutSections.forEach { $0.delegate?.registerDecorationView?(layout)}
    }
    /// Retrieves the section at the given index path
    public func getCompositionalLayoutableSection(at indexPath: IndexPath) -> CompositionalLayoutableSection {
        return self.compositionalLayoutSections[indexPath.section]
    }
    /// Constructs and returns a UICollectionViewCompositionalLayout instance based on the compositional layout sections
    public var collectionViewCompositionalLayout: UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionLayout = self.getCompositionalLayoutableSection(at: IndexPath(row: 0, section: sectionIndex))
                .layout?
                .sectionLayout(at: sectionIndex, layoutEnvironment: layoutEnvironment)
            return sectionLayout
        }
        //
        self.registerDecorationViews(for: layout)
        //
        return layout
    }
}
