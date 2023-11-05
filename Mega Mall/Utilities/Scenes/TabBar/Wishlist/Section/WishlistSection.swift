//
//  Wishlist.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 05/11/2023.
//

import UIKit
import CompositionalLayoutableSection

// MARK: - A custom section for displaying Wishlist in a collection view.
class WishlistCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = Product
    typealias CellType = WishlistCollectionViewCell
    //
    var items: [ItemsType] = []
    var viewController: UIViewController?
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
// MARK: - Wishlist CollectionView Section Data Source
extension WishlistCollectionViewSection: CompositionalLayoutableSectionDataSource {
    // number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        let product = items[indexPath.item]
        cell.configure(with: product)
        return cell
    }
}
// MARK: - Wishlist CollectionView Section Layout
extension WishlistCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 20 } // The spacing between items in the section.
    var height: CGFloat { 120 } // The height of each item in the section.
    /// - Returns: The layout for an item within the group.
    var itemLayoutInGroup: NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    ///  - Returns: The layout for a group within the section.
    var groupLayoutInSection: NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayoutInGroup])
        // group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: 0)
        return group
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: spacing, bottom: 20, trailing: spacing)
        return section
    }
}
// MARK: - Wishlist CollectionView Section Delegate
extension WishlistCollectionViewSection: CompositionalLayoutableSectionDelegate {
    /// Registers the cell type with the given collection view.
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
    /*
     ///
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     }
     */
}

// MARK: - Private Handelers
extension WishlistCollectionViewSection {
}
