//
//  Categories.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit
import CompositionalLayoutableSection
import ViewAnimator
import Extensions

class HomeCategoriesCollectionViewSection: CompositionalLayoutableSection {
    @UserDefault<Bool>(key: \.login) var login
    ///
    typealias ResposeType = Category
    typealias CellType = CategoriesCollectionViewCell
    typealias TopSupplementaryViewType = MegaCollectionReusableView
    ///
    var items: [ResposeType] = []
    var viewController: UIViewController?
    var topViewModel: MegaCollectionReusableView.ViewModel?
    ///
    override init() {
        super.init()
        delegate = self
        dataSource = self
        layout = self
    }
    ///
    private var isConfigured = false
    public func configure(owner viewController: UIViewController,
                          topViewModel: MegaCollectionReusableView.ViewModel?) {
        guard !isConfigured else { return }
        isConfigured = true
        self.viewController = viewController
        self.topViewModel = topViewModel
    }
}
// MARK: - Categories CollectionView Section Data Source
extension HomeCategoriesCollectionViewSection: CompositionalLayoutableSectionDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        let category = items[indexPath.item]
        cell.configure(with: category)
        cell.animate(animations: [AnimationType.from(direction: .bottom, offset: 60)])
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
        } else {
            Logger.log("Failed to configure Categories top View Model", category: \.home, level: .fault)
        }
        return view
    }
}
// MARK: - Categories CollectionView Section Layout
extension HomeCategoriesCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 20 } // The spacing between items in the section.
    var width: CGFloat { 68 } // The width of each item in the section.
    var height: CGFloat { 76 } // The height of each item in the section.
    var itemLayoutInGroup: NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    var groupLayoutInSection: NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayoutInGroup])
        return group
    }
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection)
        section.contentInsets = .init(top: 0, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [topSupplementaryItem]
        return section
    }
    ///
    private var topSupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem {
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(54))
        return  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize,
                                                            elementKind: TopSupplementaryViewType.identifier,
                                                            alignment: .top)
    }
}
// MARK: - Categories CollectionView Section Delegate
extension HomeCategoriesCollectionViewSection: CompositionalLayoutableSectionDelegate {
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
    //
    func registerSupplementaryView(_ collectionView: UICollectionView) {
        collectionView.register(TopSupplementaryViewType.self, supplementaryViewOfKind: TopSupplementaryViewType.identifier)
    }
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoginManager.shared.checkLogin(loginHandeler: { [unowned self] in
            let category = items[indexPath.row]
            let categoryViewModel = CategoryViewModel(category: category)
            let categoryViewController = CategoryViewController(viewModel: categoryViewModel)
            if let navigationController = self.viewController?.navigationController {
                navigationController.pushViewController(categoryViewController, animated: true)
            } else {
                Logger.log("Failed to get navigationController", category: \.home, level: .fault)
            }
        })
    }
}
