//
//  Product.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit
import CompositionalLayoutableSection
import ViewAnimator

class AddsCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = Adds
    typealias CellType = AddsCollectionViewCell
    var items: [ItemsType] = []
    override init() {
        super.init()
        delegate = self
        dataSource = self
        layout = self
    }
}
// MARK: - Offers CollectionView Section Data Source
//
extension AddsCollectionViewSection: CompositionalLayoutableSectionDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        cell.animate(animations: [AnimationType.from(direction: .right, offset: 60)], initialAlpha: 0.0)
        let adds = items[indexPath.item]
        cell.configure(with: adds)
        return cell
    }
}
// MARK: - Offers CollectionView Section Layout
extension AddsCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 20 }
    var height: CGFloat { 216 }
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayoutInGroup()])
        return group
    }
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection())
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
// MARK: - Offers CollectionView Section Delegate
extension AddsCollectionViewSection: CompositionalLayoutableSectionDelegate {
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
}
