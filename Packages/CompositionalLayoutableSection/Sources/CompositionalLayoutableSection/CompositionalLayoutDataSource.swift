//
//  CompositionalLayoutDataSource.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit
// swiftlint:disable all
@available(iOS 13.0, *)
open class CompositionalLayoutDataSource: NSObject, UICollectionViewDataSource {
    public let provider: any CompositionalLayoutProvider
    //
    public init(provider: any CompositionalLayoutProvider) {
        self.provider = provider
    }
    //
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.provider.compositionalLayoutSections.count
    }
    //
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let compositionalSection = self.provider.getCompositionalLayoutableSection(at: IndexPath(item: 0, section: section))
        return compositionalSection.dataSource?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
    }
    //
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        return section.dataSource?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    //
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        return section.dataSource?.collectionView?(collectionView,viewForSupplementaryElementOfKind: kind,at: indexPath) ?? UICollectionReusableView()
    }
    //
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        return section.dataSource?.collectionView?(collectionView, canMoveItemAt: indexPath) ?? false
    }
    //
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let section = self.provider.getCompositionalLayoutableSection(at: sourceIndexPath)
        section.dataSource?.collectionView?(collectionView, moveItemAt: sourceIndexPath, to: destinationIndexPath)
    }
}
// swiftlint:enable all
