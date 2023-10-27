//
//  News.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit
import CompositionalLayoutableSection

// MARK: - A custom section for displaying News in a collection view.
class NewsCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = String
    typealias CellType = NewsCollectionViewCell
     typealias TopSupplementaryViewType = MegaCollectionReusableView
    var items: [ItemsType] = []
    var viewController: UIViewController?
    override init() {
        super.init()
        delegate = self
        dataSource = self
        layout = self
    }
    private var isConfigured = false
    public func configure(ownerViewController: UIViewController) {
        guard !isConfigured else { return }
        self.viewController = ownerViewController
    }
}
// MARK: - News CollectionView Section Data Source
extension NewsCollectionViewSection: CompositionalLayoutableSectionDataSource {
    // number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        return cell
    }
    // view For Supplementary Element Of Kind
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(TopSupplementaryViewType.self,
                                                                   ofKind: TopSupplementaryViewType.identifier,
                                                                   for: indexPath)
        view.configure(with: .init(label: "Latest News"))
        return view
    }
}
// MARK: - News CollectionView Section Layout
extension NewsCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 20 } // The spacing between items in the section.
    var height: CGFloat { 150 } // The height of each item in the section.
    /// - Returns: The layout for an item within the group.
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    ///  - Returns: The layout for a group within the section.
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayoutInGroup()])
        // group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: 0)
        return group
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection())
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        section.interGroupSpacing = 16
        section.boundarySupplementaryItems = [topSupplementaryItem]
        return section
    }
    //
    private var topSupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        return  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                            elementKind: TopSupplementaryViewType.identifier,
                                                            alignment: .top)
    }
}
// MARK: - News CollectionView Section Delegate
extension NewsCollectionViewSection: CompositionalLayoutableSectionDelegate {
    /// Registers the cell type with the given collection view.
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
    /*
    /**
     Registers the supplementary view types (header and pagination) with the given
     - Note: you can register here more supplementary views for the section by changing 'supplementaryViewOfKind'
     */
     func registerSupplementaryView(_ collectionView: UICollectionView) {
        collectionView.register(TopSupplementaryViewType.self, supplementaryViewOfKind: TopSupplementaryViewType.identifier)
     }
     */
    /*
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     }
     */
}

// MARK: - Private Handelers
extension NewsCollectionViewSection {
}
