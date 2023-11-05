//
//  ProductDetailsViewController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 04/11/2023.
//

import UIKit
import Extensions
import CompositionalLayoutableSection
import MakeConstraints
import ViewAnimator

class ProductDetailsViewController: UICollectionViewController, CompositionalLayoutProvider {
    // MARK: Outlets
    //
    let actionView = ProductDetailsActionView()
    //
    // MARK: - Properties
    private let viewModel: ProductDetailsViewModel
    ///
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    ///
    lazy var delegate = CompositionalLayoutDelegate(provider: self)
    lazy var dataSource = CompositionalLayoutDataSource(provider: self)
    //
    // MARK: - Init
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: .init())
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.tabBarIsHidden = true
    }
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        ///
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        ///
        let section = ProductDetailCollectionViewSection()
        section.update(collectionView, withItems: [viewModel.product])
        section.configure(owner: self)
        compositionalLayoutSections.append(section)
        ///
        let reviewsSection = ReviewsCollectionViewSection()
        reviewsSection.configure(owner: self, product: viewModel.product)
        compositionalLayoutSections.append(reviewsSection)
        ///
        let productsSection = ProductsCollectionViewSection()
        productsSection.update(collectionView, withItems: viewModel.product.featuredProducts)
        productsSection.configure(owner: self, topViewModel: .init(label: "Featured Product", button: "See All", action: {}))
        compositionalLayoutSections.append(productsSection)
        ///
        collectionView.updateCollectionViewCompositionalLayout(for: self)
    }
    ///
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        TabBarViewModel.shared.tabBarIsHidden = false
    }
}
//
// MARK: - Actions
extension ProductDetailsViewController {}
//
// MARK: - Configurations
extension ProductDetailsViewController {
    private func configureViews() {
        view.backgroundColor = .megaPrimaryPureWhite
        collectionView.backgroundColor = .megaPrimaryPureWhite
        navigationItem.addTitleLabel(with: "Product Details", color: .megaPrimaryNavyBlack, font: .h3)
        configureLeftBartButtonItems()
        configureActionView()
    }
    private func configureLeftBartButtonItems() {
        guard let navigationController = navigationController as? MegaNavigationController else {
            Logger.log("Home Navigation Controller must be of type Mega", category: \.home, level: .fault)
            return
        }
        navigationController.addShopingCartItem()
    }
    private func configureActionView() {
        view.addSubview(actionView)
        actionView.fillXSuperView(paddingLeft: 20, paddingRight: 20)
        actionView.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        actionView.animate(animations: [AnimationType.from(direction: .bottom, offset: 100)], initialAlpha: 0, delay: 1)
        actionView.configure(with: viewModel.product)
    }
}
//
// MARK: - Private Handlers
private extension ProductDetailsViewController {}
