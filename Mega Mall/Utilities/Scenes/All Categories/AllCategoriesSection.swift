//
//  Categories.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 30/10/2023.
//

import UIKit
import CompositionalLayoutableSection

// MARK: - A custom section for displaying Categories in a collection view.
class AllCategoriesCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = Category
    typealias CellType = CategoriesCollectionViewCell
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
// MARK: - Categories CollectionView Section Data Source
extension AllCategoriesCollectionViewSection: CompositionalLayoutableSectionDataSource {
    // number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        let category = items[indexPath.item]
        cell.configure(with: category)
        return cell
    }
}
// MARK: - Categories CollectionView Section Layout
extension AllCategoriesCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 10 } // The spacing between items in the section.
    var width: CGFloat { 68 + spacing } // The width of each item in the section.
    var height: CGFloat { 76 } // The height of each item in the section.
    /// - Returns: The layout for an item within the group.
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    ///  - Returns: The layout for a group within the section.
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let group: NSCollectionLayoutGroup
        if #available(iOS 16.0, *) {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: itemLayoutInGroup(), count: 4)
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayoutInGroup(), count: 4)
        }
        return group
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection())
        section.interGroupSpacing = 16
        return section
    }
}
// MARK: - Categories CollectionView Section Delegate
extension AllCategoriesCollectionViewSection: CompositionalLayoutableSectionDelegate {
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
extension AllCategoriesCollectionViewSection {
}
