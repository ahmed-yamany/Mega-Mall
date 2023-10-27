import UIKit
import ViewAnimator
import Extensions
import CompositionalLayoutableSection

class HomeViewController: UIViewController, CompositionalLayoutProvider {
    // MARK: Outlets
    //
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: Properties
    private let viewModel: HomeViewModelType
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    //
    // MARK: Init
    init() {
        self.viewModel = HomeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    // MARK: Lifecycle
    let delegate = CompositionalLayoutDelegate()
    let datasource = CompositionalLayoutDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        //
        delegate.updateProvider(with: self)
        datasource.updateProvider(with: self)
        //
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
        //
        let section = AddsCollectionViewSection()
        compositionalLayoutSections.append(section)
        section.update(collectionView, withItems: Array(repeating: "10", count: 10))
        //
        let categoriesSection = CategoriesCollectionViewSection()
        compositionalLayoutSections.append(categoriesSection)
        categoriesSection.update(collectionView, withItems: Array(repeating: "10", count: 10))
        //
        let productsSection = ProductsCollectionViewSection()
        compositionalLayoutSections.append(productsSection)
        productsSection.configure(ownerViewController: self,
                                  topViewModel: .init(label: "Featured Product", button: L10n.App.seeAll))
        productsSection.update(collectionView, withItems: Array(repeating: "10", count: 10))
        //
        let section2 = OfferCollectionViewSection()
        compositionalLayoutSections.append(section2)
        section2.update(collectionView, withItems: Array(repeating: "10", count: 1))
        //
        let productsSection1 = ProductsCollectionViewSection()
        compositionalLayoutSections.append(productsSection1)
        productsSection1.configure(ownerViewController: self, topViewModel: .init(label: "Best Sellers", button: L10n.App.seeAll))
        productsSection1.update(collectionView, withItems: Array(repeating: "10", count: 10))
        //
        let section3 = OfferCollectionViewSection()
        compositionalLayoutSections.append(section3)
        section3.update(collectionView, withItems: Array(repeating: "10", count: 1))
        //
        let productsSection2 = ProductsCollectionViewSection()
        compositionalLayoutSections.append(productsSection2)
        productsSection2.configure(ownerViewController: self,
                                   topViewModel: .init(label: "New Arrivals", button: L10n.App.seeAll))
        productsSection2.update(collectionView, withItems: Array(repeating: "10", count: 10))
        //
        let productsSection3 = ProductsCollectionViewSection()
        compositionalLayoutSections.append(productsSection3)
        productsSection3.configure(ownerViewController: self,
                                   topViewModel: .init(label: "Top Rated Product", button: L10n.App.seeAll))
        productsSection3.update(collectionView, withItems: Array(repeating: "10", count: 10))
        //
        let productsSection4 = ProductsCollectionViewSection()
        compositionalLayoutSections.append(productsSection4)
        productsSection4.configure(ownerViewController: self,
                                   topViewModel: .init(label: "Special Offers", button: L10n.App.seeAll))
        productsSection4.update(collectionView, withItems: Array(repeating: "10", count: 10))
        //
        let news = NewsCollectionViewSection()
        compositionalLayoutSections.append(news)
        news.configure(ownerViewController: self)
        news.update(collectionView, withItems: Array(repeating: "10", count: 3))
        //
        // this must be called after adding all sections to sections array
        collectionView.updatecollectionViewCompositionalLayout(with: self)
    }
}
//
// MARK: - Actions
extension HomeViewController {}
//
// MARK: - Configurations
extension HomeViewController {
    private func configureViews() {
        configureNavigationItem()
    }
    private func configureNavigationItem() {
        navigationItem.addTitleLabel(with: "Mega Mall", color: .megaPrimaryBlueOcean, font: .h2)
        congigureLeftBartButtonItems()
    }
    private func congigureLeftBartButtonItems() {
        let notificationView = UIImageView(image: .megaNotification.withRenderingMode(.alwaysOriginal))
        let shopingCartView = UIImageView(image: .megaShopingCart.withRenderingMode(.alwaysOriginal))
        //
        let notificationItem = UIBarButtonItem(customView: notificationView)
        let shopingCartItem = UIBarButtonItem(customView: shopingCartView)
        //
        navigationItem.rightBarButtonItems = [shopingCartItem, notificationItem]
        //
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(notificationViewAction))
        let shopingCarttapGesture = UITapGestureRecognizer(target: self, action: #selector(shopingCartViewAction))
        //
        notificationView.addGestureRecognizer(tapGesture)
        shopingCartView.addGestureRecognizer(shopingCarttapGesture)
    }
}
//
// MARK: - Private Handlers
private extension HomeViewController {}

// MARK: - Actions
private extension HomeViewController {
    @objc private func notificationViewAction(_ sender: UITapGestureRecognizer) {
        sender.view?.animate(animations: [AnimationType.rotate(angle: -30)])
    }
    @objc private func shopingCartViewAction(_ sender: UITapGestureRecognizer) {
        sender.view?.animate(animations: [AnimationType.rotate(angle: -30)])
    }
}
