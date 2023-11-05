//
//  ProductImages.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 04/11/2023.
//

import UIKit
import CompositionalLayoutableSection
import Combine

// MARK: - A custom section for displaying ProductImages in a collection view.
class ProductImagesCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = UIImage?
    typealias CellType = ProductImagesCollectionViewCell
    typealias SupplementaryViewType = ProductImagesSupplementaryView
    //
    @Published var currenPageNumber: Int = 0
    var currentPageNumberCancellable: AnyCancellable?
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
// MARK: - ProductImages CollectionView Section Data Source
extension ProductImagesCollectionViewSection: CompositionalLayoutableSectionDataSource {
    // number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        let image = items[indexPath.item]
        cell.productImageView.image = image
        return cell
    }
    // view For Supplementary Element Of Kind
     func collectionView(_ collectionView: UICollectionView,
                         viewForSupplementaryElementOfKind kind: String,
                         at indexPath: IndexPath) -> UICollectionReusableView {
         let view = collectionView.dequeueReusableSupplementaryView(SupplementaryViewType.self,
                                                                    ofKind: SupplementaryViewType.identifier,
                                                                    for: indexPath)
         ///
         let imagesCount = items.count
         currentPageNumberCancellable = AnyCancellable($currenPageNumber.sink { pageNumber in
             view.label.text = "\(pageNumber+1)/\(imagesCount) Image"
         })
         ///
         return view
     }
}
// MARK: - ProductImages CollectionView Section Layout
extension ProductImagesCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 20 } // The spacing between items in the section.
    var height: CGFloat { 270 } // The height of each item in the section.
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
        section.orthogonalScrollingBehavior = .groupPagingCentered
        ///
        section.visibleItemsInvalidationHandler = { [unowned self] in
            self.currentPageDidChanged(withItems: $0, offset: $1, layoutEnvironment: $2) { page in
                currenPageNumber = page
            }
        }
        ///
         section.boundarySupplementaryItems = [supplementaryItem]
        return section
    }
}
// MARK: - ProductImages CollectionView Section Delegate
extension ProductImagesCollectionViewSection: CompositionalLayoutableSectionDelegate {
    /// Registers the cell type with the given collection view.
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
    /**
     Registers the supplementary view types
     - Note: you can register here more supplementary views for the section by changing 'supplementaryViewOfKind'
     */
     func registerSupplementaryView(_ collectionView: UICollectionView) {
        collectionView.register(SupplementaryViewType.self, supplementaryViewOfKind: SupplementaryViewType.identifier)
     }
}

// MARK: - Private Handelers
extension ProductImagesCollectionViewSection {
    private var supplementaryItem: NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
        return  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                            elementKind: SupplementaryViewType.identifier,
                                                            alignment: .bottom)
    }
}
