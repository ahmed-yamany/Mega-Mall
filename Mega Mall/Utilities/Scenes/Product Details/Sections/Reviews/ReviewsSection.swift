//
//  Reviews.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 05/11/2023.
//

import UIKit
import CompositionalLayoutableSection

// MARK: - A custom section for displaying Reviews in a collection view.
class ReviewsCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = Review
    typealias CellType = ReviewsCollectionViewCell
     typealias TopSupplementaryViewType = ReviewsSectionSupplementaryView
     typealias BottomSupplementaryViewType = ButtonCollectionReusableView
    // typealias DecorationViewType = UICollectionReusableView
    //
    var items: [ItemsType] = []
    var viewController: UIViewController?
    var product: Product!
    override init() {
        super.init()
        delegate = self
        dataSource = self
        layout = self
    }
    //
    private var isConfigured = false
    public func configure(owner viewController: UIViewController, product: Product) {
        guard !isConfigured else { return }
        isConfigured = true
        self.viewController = viewController
        self.product = product
        items = product.reviews
    }
}
// MARK: - Reviews CollectionView Section Data Source
extension ReviewsCollectionViewSection: CompositionalLayoutableSectionDataSource {
    // number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        let review = items[indexPath.item]
        cell.configure(with: review)
        return cell
    }
    // view For Supplementary Element Of Kind
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view: UICollectionReusableView
        ///
        if TopSupplementaryViewType.identifier == kind {
            view = dequeueTopSupplementaryView(collectionView, at: indexPath)
        } else {
            view = dequeueBottomSupplementaryView(collectionView, at: indexPath)
        }
        ///
        return view
    }
    ///
    func dequeueTopSupplementaryView(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(TopSupplementaryViewType.self,
                                                                   ofKind: TopSupplementaryViewType.identifier,
                                                                   for: indexPath)
        view.configure(with: product)
        return view
    }
    ///
    func dequeueBottomSupplementaryView(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(BottomSupplementaryViewType.self,
                                                                   ofKind: BottomSupplementaryViewType.identifier,
                                                                   for: indexPath)
        view.configure(with: .init(title: "See All Review", target: self, action: #selector(seeAllReviewsAction)))
        return view
    }
    ///
    @objc private func seeAllReviewsAction() {
    }
}
// MARK: - Reviews CollectionView Section Layout
extension ReviewsCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 20 } // The spacing between items in the section.
    var height: CGFloat { 88 } // The height of each item in the section.
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
        return group
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection)
        // section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        section.boundarySupplementaryItems = [bottomSupplementaryItem, topSupplementaryItem]
        return section
    }
}
// MARK: - Reviews CollectionView Section Delegate
extension ReviewsCollectionViewSection: CompositionalLayoutableSectionDelegate {
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
        collectionView.register(BottomSupplementaryViewType.self, supplementaryViewOfKind: BottomSupplementaryViewType.identifier)
     }
    /*
     ///
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     }
     */
}

// MARK: - Private Handelers
extension ReviewsCollectionViewSection {
    private var topSupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        return  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                            elementKind: TopSupplementaryViewType.identifier,
                                                            alignment: .top)
    }
    private var bottomSupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(88))
        return  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                            elementKind: BottomSupplementaryViewType.identifier,
                                                            alignment: .bottom)
    }
}
