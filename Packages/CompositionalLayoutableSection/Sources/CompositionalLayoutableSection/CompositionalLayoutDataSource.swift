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
    open var provider: (any CompositionalLayoutProvider)?
    public func updateProvider(with provider: any CompositionalLayoutProvider) {
        self.provider = provider
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.provider?.compositionalLayoutSections.count ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let compositionalSection = self.provider?.getCompositionalLayoutableSection(at: IndexPath(item: 0, section: section))
        return compositionalSection?.dataSource?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.provider?.getCompositionalLayoutableSection(at: indexPath)
        return section?.dataSource?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = self.provider?.getCompositionalLayoutableSection(at: indexPath)
        return section?.dataSource?.collectionView?(collectionView,viewForSupplementaryElementOfKind: kind,at: indexPath) ?? UICollectionReusableView()
    }
}
// swiftlint:enable all
