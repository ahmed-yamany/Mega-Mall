//
//  WishListViewController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 25/10/2023.
//

import UIKit
import CompositionalLayoutableSection
import Extensions

class WishListViewController: UICollectionViewController, CompositionalLayoutProvider {
    // MARK: Properties
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    ///
    lazy var delegate = CompositionalLayoutDelegate(provider: self)
    lazy var dataSource = CompositionalLayoutDataSource(provider: self)
    // MARK: - Init
    init() {
        super.init(collectionViewLayout: .init())
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        ///
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        ///
        let section = WishlistCollectionViewSection()
        section.configure(owner: self)
        ///
        TabBarViewModel.shared.$whishies.sink { [unowned self] wisheies in
            section.items = wisheies.reversed()
            collectionView.reloadData()
        }.store(in: &TabBarViewModel.shared.cancellableSet)
        ///
        compositionalLayoutSections.append(section)
        collectionView.updateCollectionViewCompositionalLayout(for: self)
    }
}
//
// MARK: - Private Handlers
private extension WishListViewController {
    func configureViews() {
        view.backgroundColor = .megaSecondaryOffGray
        collectionView.backgroundColor = .megaSecondaryOffGray
        navigationItem.addTitleLabel(with: "Whishlist", color: .megaPrimaryBlueOcean, font: .h2)
    }
}
//
// MARK: - Actions
private extension WishListViewController {
}
