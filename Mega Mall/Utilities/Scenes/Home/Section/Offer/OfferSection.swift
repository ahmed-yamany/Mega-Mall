//
//  Offer.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit
import CompositionalLayoutableSection

// MARK: - A custom section for displaying Offer in a collection view.
class OfferCollectionViewSection: CompositionalLayoutableSection {
    typealias ResposeType = Offer
    typealias CellType = OfferCollectionViewCell
    typealias DecorationViewType = SectionDecorationView
    //
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
// MARK: - Offer CollectionView Section Data Source
extension OfferCollectionViewSection: CompositionalLayoutableSectionDataSource {
    // number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        let offer = items[indexPath.item]
        cell.configure(with: offer)
        return cell
    }
}
// MARK: - Offer CollectionView Section Layout
extension OfferCollectionViewSection: CompositionalLayoutableSectionLayout {
    var height: CGFloat { 216 } // The height of each item in the section.
    /// - Returns: The layout for an item within the group.
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    ///  - Returns: The layout for a group within the section.
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayoutInGroup()])
        return group
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection())
        //
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        //
        let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: DecorationViewType.identifier)
        section.decorationItems = [sectionBackground]
        //
        return section
    }
}
// MARK: - Offer CollectionView Section Delegate
extension OfferCollectionViewSection: CompositionalLayoutableSectionDelegate {
    /// Registers the cell type with the given collection view.
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
    /// Registers the Decoration view for the secition
    func registerDecorationView(_ layout: UICollectionViewCompositionalLayout) {
        layout.register(DecorationViewType.self, forDecorationViewOfKind: DecorationViewType.identifier)
    }
}

// MARK: - Private Handelers
extension OfferCollectionViewSection {
}
