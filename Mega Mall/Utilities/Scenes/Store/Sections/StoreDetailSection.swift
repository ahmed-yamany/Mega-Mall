//
//  StoreDetail.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 05/11/2023.
//

import UIKit
import CompositionalLayoutableSection

// MARK: - A custom section for displaying StoreDetail in a collection view.
class StoreDetailCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = Store
    typealias CellType = StoreDetailCollectionViewCell
    ///
    var items: [ItemsType] = []
    var viewController: UIViewController!
    ///
    override init() {
        super.init()
        delegate = self
        dataSource = self
        layout = self
    }
    //
    private var isConfigured = false
    public func configure(owner viewController: UIViewController) {
        guard !isConfigured else { return }
        isConfigured = true
        self.viewController = viewController
    }
}
// MARK: - StoreDetail CollectionView Section Data Source
extension StoreDetailCollectionViewSection: CompositionalLayoutableSectionDataSource {
    // number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        let store = items[indexPath.item]
        cell.configure(with: store)
        return cell
    }
}
// MARK: - StoreDetail CollectionView Section Layout
extension StoreDetailCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 20 } // The spacing between items in the section.
    /// - Returns: The layout for an item within the group.
    var itemLayoutInGroup: NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    ///  - Returns: The layout for a group within the section.
    var groupLayoutInSection: NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayoutInGroup])
        // group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: 0)
        return group
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection)
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        return section
    }
}
// MARK: - StoreDetail CollectionView Section Delegate
extension StoreDetailCollectionViewSection: CompositionalLayoutableSectionDelegate {
    /// Registers the cell type with the given collection view.
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
}

// MARK: - Private Handelers
extension StoreDetailCollectionViewSection {
}
