//
//  Products.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit
import CompositionalLayoutableSection
import ViewAnimator

// A custom section for displaying Products in a collection view.
class ProductsCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = Product
    typealias CellType = ProductCollectionViewCell
    typealias TopSupplementaryViewType = MegaCollectionReusableView
    typealias DecorationViewType = SectionDecorationView
    //
    var items: [ItemsType] = []
    var viewController: UIViewController?
    var topViewModel: MegaCollectionReusableView.ViewModel?
    override init() {
        super.init()
        delegate = self
        dataSource = self
        layout = self
    }
    private var isConfigured = false
    public func configure(owner viewController: UIViewController,
                          topViewModel: MegaCollectionReusableView.ViewModel) {
        guard !isConfigured else { return }
        self.viewController = viewController
        self.topViewModel = topViewModel
    }
}
// MARK: - Products CollectionView Section Data Source
//
extension ProductsCollectionViewSection: CompositionalLayoutableSectionDataSource {
    ///
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        let product = items[indexPath.item]
        cell.configure(with: product)
        cell.animate(animations: [AnimationType.from(direction: .left, offset: 60)])
        return cell
    }
    /// view For Supplementary Element Of Kind
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(TopSupplementaryViewType.self,
                                                                   ofKind: TopSupplementaryViewType.identifier,
                                                                   for: indexPath)
        if let topViewModel {
            view.configure(with: topViewModel)
        }
        return view
    }
}
// MARK: - Products CollectionView Section Layout
extension ProductsCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 20 } // The spacing between items in the section.
    var width: CGFloat { 156 } // The width of each item in the section.
    var height: CGFloat { 242 } // The height of each item in the section.
    /// - Returns: The layout for an item within the group.
    func itemLayoutInGroup() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    /// - Returns: The layout for a group within the section.
    func groupLayoutInSection() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayoutInGroup()])
        return group
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection())
        //
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        //
        section.boundarySupplementaryItems = [topSupplementaryItem]
        //
        let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: DecorationViewType.identifier)
        section.decorationItems = [sectionBackground]
        //
        return section
    }
}
// MARK: - Products CollectionView Section Delegate
extension ProductsCollectionViewSection: CompositionalLayoutableSectionDelegate {
    /// Registers the cell type with the given collection view.
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
    /**
     Registers the supplementary view types
     - Note: you can register here more supplementary views for the section by changing 'supplementaryViewOfKind'
     */
    func registerSupplementaryView(_ collectionView: UICollectionView) {
        collectionView.register(TopSupplementaryViewType.self, supplementaryViewOfKind: TopSupplementaryViewType.identifier)
    }
    /// Registers the Decoration view for the secition
    func registerDecorationView(_ layout: UICollectionViewCompositionalLayout) {
        layout.register(DecorationViewType.self, forDecorationViewOfKind: DecorationViewType.identifier)
    }
    ///
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - Private Handelers
extension ProductsCollectionViewSection {
    private var topSupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        return  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                            elementKind: TopSupplementaryViewType.identifier,
                                                            alignment: .top)
    }
}
