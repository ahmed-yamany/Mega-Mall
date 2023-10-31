//
//  DetailNews.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 31/10/2023.
//

import UIKit
import CompositionalLayoutableSection

// MARK: - A custom section for displaying DetailNews in a collection view.
class DetailNewsCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = News
    typealias CellType = DetailNewsCollectionViewCell
    ///
    var items: [ItemsType] = []
    var viewController: UIViewController?
    override init() {
        super.init()
        delegate = self
        dataSource = self
        layout = self
    }
    ///
    private var isConfigured = false
    public func configure(owner viewController: UIViewController) {
        guard !isConfigured else { return }
        isConfigured = true
        self.viewController = viewController
    }
}
// MARK: - DetailNews CollectionView Section Data Source
extension DetailNewsCollectionViewSection: CompositionalLayoutableSectionDataSource {
    // number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        let news = items[indexPath.item]
        cell.configure(with: news)
        return cell
    }
}
// MARK: - DetailNews CollectionView Section Layout
extension DetailNewsCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 20 } // The spacing between items in the section.
    /// - Returns: The layout for an item within the group.
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    ///  - Returns: The layout for a group within the section.
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayoutInGroup()])
        group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        return group
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection())
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)
        return section
    }
}
// MARK: - DetailNews CollectionView Section Delegate
extension DetailNewsCollectionViewSection: CompositionalLayoutableSectionDelegate {
    /// Registers the cell type with the given collection view.
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
}

// MARK: - Private Handelers
extension DetailNewsCollectionViewSection {
}
