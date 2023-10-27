//
//  Categories.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit
import CompositionalLayoutableSection

class CategoriesCollectionViewSection: CompositionalLayoutableSection {
    typealias ResposeType = String
    typealias CellType = CategoriesCollectionViewCell
    typealias TopSupplementaryViewType = MegaCollectionReusableView
    var items: [ResposeType] = []
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
// MARK: - Categories CollectionView Section Data Source
extension CategoriesCollectionViewSection: CompositionalLayoutableSectionDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        return cell
    }
    /// view For Supplementary Element Of Kind
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(TopSupplementaryViewType.self,
                                                                   ofKind: TopSupplementaryViewType.identifier,
                                                                   for: indexPath)
        view.configure(with: .init(label: "Categories", button: L10n.App.seeAll))
        return view
    }
}
// MARK: - Categories CollectionView Section Layout
extension CategoriesCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 12 }
    var height: CGFloat { 216 }
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(80), heightDimension: .absolute(76))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayoutInGroup()])
        return group
    }
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection())
        section.contentInsets = .init(top: spacing, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [topSupplementaryItem]
        return section
    }
    ///
    private var topSupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        return  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                            elementKind: TopSupplementaryViewType.identifier,
                                                            alignment: .top)
    }
}
// MARK: - Categories CollectionView Section Delegate
extension CategoriesCollectionViewSection: CompositionalLayoutableSectionDelegate {
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
    func registerSupplementaryView(_ collectionView: UICollectionView) {
        collectionView.register(TopSupplementaryViewType.self, supplementaryViewOfKind: TopSupplementaryViewType.identifier)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
