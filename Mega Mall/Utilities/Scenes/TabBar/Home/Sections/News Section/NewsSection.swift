//
//  News.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit
import CompositionalLayoutableSection
import ViewAnimator

// MARK: - A custom section for displaying News in a collection view.
class NewsCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = News
    typealias CellType = NewsCollectionViewCell
    typealias TopSupplementaryViewType = MegaCollectionReusableView
    typealias BottomSupplementaryViewType = ButtonCollectionReusableView
    //
    var items: [ItemsType] = []
    var viewController: UIViewController?
    var topViewModel: MegaCollectionReusableView.ViewModel?
    var bottomViewModel: ButtonCollectionReusableView.ViewModel?
    override init() {
        super.init()
        delegate = self
        dataSource = self
        layout = self
    }
    private var isConfigured = false
    public func configure(owner viewController: UIViewController,
                          topViewModel: MegaCollectionReusableView.ViewModel? = nil,
                          bottomViewModel: ButtonCollectionReusableView.ViewModel? = nil ) {
        guard !isConfigured else { return }
        isConfigured = true
        self.viewController = viewController
        self.topViewModel = topViewModel
        self.bottomViewModel = bottomViewModel
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
        let news = items[indexPath.item]
        cell.configure(with: news)
        cell.animate(animations: [AnimationType.from(direction: .left, offset: 60)], initialAlpha: 0)
        return cell
    }
    // view For Supplementary Element Of Kind
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view: UICollectionReusableView
        //
        if kind == TopSupplementaryViewType.identifier {
           view = dequeueTopView(collectionView, at: indexPath)
        } else {
            view = dequeueBottomView(collectionView, at: indexPath)
        }
        //
        return view
    }
}
// MARK: - News CollectionView Section Layout
extension NewsCollectionViewSection: CompositionalLayoutableSectionLayout {
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
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayoutInGroup])
        return group
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection)
        ///
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        section.interGroupSpacing = 16
        ///
        var supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []
        ///
        if topViewModel != nil {
            supplementaryItems.append(topSupplementaryItem)
        }
        ///
        if bottomViewModel != nil {
            supplementaryItems.append(bottomSupplementaryItem)
        }
        ///
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }
}
// MARK: - News CollectionView Section Delegate
extension NewsCollectionViewSection: CompositionalLayoutableSectionDelegate {
    /// Registers the cell type with the given collection view.
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
    /**
     Registers the supplementary view types (header and pagination) with the given
     - Note: you can register here more supplementary views for the section by changing 'supplementaryViewOfKind'
     */
     func registerSupplementaryView(_ collectionView: UICollectionView) {
        collectionView.register(TopSupplementaryViewType.self, supplementaryViewOfKind: TopSupplementaryViewType.identifier)
        collectionView.register(BottomSupplementaryViewType.self, supplementaryViewOfKind: BottomSupplementaryViewType.identifier)
     }
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoginManager.shared.checkLogin(loginHandeler: { [unowned self] in
            let news = items[indexPath.item]
            let viewModel = DetailNewsViewModel(news: news)
            let detailNewsVC = DetailNewsViewController(viewModel: viewModel)
            viewController?.navigationController?.pushViewController(detailNewsVC, animated: true)
        })
    }
}

// MARK: - Private Handelers
extension NewsCollectionViewSection {
    //
    private var topSupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        return  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                            elementKind: TopSupplementaryViewType.identifier,
                                                            alignment: .top)
    }
    //
    private var bottomSupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let item = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                               elementKind: BottomSupplementaryViewType.identifier,
                                                               alignment: .bottom)
        return item
    }
    //
    private func dequeueTopView(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(TopSupplementaryViewType.self,
                                                                   ofKind: TopSupplementaryViewType.identifier,
                                                                   for: indexPath)
        if let topViewModel {
            view.configure(with: topViewModel)
        }
        return view
    }
    //
    private func dequeueBottomView(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(BottomSupplementaryViewType.self,
                                                                   ofKind: BottomSupplementaryViewType.identifier,
                                                                   for: indexPath)
        if let bottomViewModel {
            view.configure(with: bottomViewModel)
        }
        return view
    }
}
