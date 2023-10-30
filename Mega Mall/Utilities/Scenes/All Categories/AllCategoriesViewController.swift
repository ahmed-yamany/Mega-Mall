//
//  CategoriesViewController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 29/10/2023.
//

import UIKit
import MakeConstraints
import CompositionalLayoutableSection

class AllCategoriesViewController: SheetViewController, CompositionalLayoutProvider {
    // MARK: - Views
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    // MARK: Properties
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    let viewModel = AllCategoriesViewModel()
    ///
    lazy var delegate = CompositionalLayoutDelegate(provider: self)
    lazy var datasource = CompositionalLayoutDataSource(provider: self)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Categories"
        configureViews()
        ///
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
        ///
        viewModel.getCategories().sink { [unowned self] categories in
            let collectionViewSection = AllCategoriesCollectionViewSection()
            collectionViewSection.update(collectionView, withItems: categories)
            compositionalLayoutSections.append(collectionViewSection)
            collectionView.updatecollectionViewCompositionalLayout(with: self)
        }.store(in: &viewModel.cancellableSet)
        ///
    }
}
// MARK: - Configure Views
private extension AllCategoriesViewController {
    func configureViews() {
        addChild(collectionView)
        collectionView.heightConstraints(200)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
    }
}
