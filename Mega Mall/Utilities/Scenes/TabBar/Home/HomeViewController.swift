import UIKit
import ViewAnimator
import Extensions
import CompositionalLayoutableSection
import Combine

class HomeViewController: UIViewController, CompositionalLayoutProvider {
    // MARK: - Outlets
    //
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: Properties
    private let viewModel: HomeViewModel
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    //
    // MARK: - Init
    init() {
        self.viewModel = HomeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var delegate = CompositionalLayoutDelegate(provider: self)
    lazy var datasource = CompositionalLayoutDataSource(provider: self)
    //
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        ///
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
        ///
        viewModel.getHome().sink { [unowned self] home in
            for section in home.sections {
                let collectionViewSection = switch section.type {
                                            case .adds: makeAddsSection(from: section)
                                            case .categories: makeCategoriesSection(from: section)
                                            case .products: makeProductsSection(from: section)
                                            case .offers: makeOffersSection(from: section)
                                            case .news: makeNewsSection(from: section)}
                compositionalLayoutSections.append(collectionViewSection)
            }
            // this must be called after adding all sections to compositionalLayoutSections array
            collectionView.updateCollectionViewCompositionalLayout(for: self)
        }
        .store(in: &viewModel.cancellableSet)
    }
}

// MARK: - Configurations
extension HomeViewController {
    private func configureViews() {
        configureNavigationItem()
    }
    //
    private func configureNavigationItem() {
        navigationItem.addTitleLabel(with: L10n.App.name, color: .megaPrimaryBlueOcean, font: .h2)
        configureLeftBartButtonItems()
    }
    //
    private func configureLeftBartButtonItems() {
        guard let navigationController = navigationController as? MegaNavigationController else {
            Logger.log("Home Navigation Controller must be of type Mega", category: \.home, level: .fault)
            return
        }
        navigationController.addShopingCartItem()
        navigationController.addNotificationItem()
    }
}

// MARK: - Private Handlers
private extension HomeViewController {
    //
    private func makeAddsSection(from section: Section) -> CompositionalLayoutableSection {
        let collectionViewsection = AddsCollectionViewSection()
        ///
        if let adds = section.adds {
            collectionViewsection.update(collectionView, withItems: adds)
        } else {
            Logger.log("could not wrap Adds this may be an error from the backend", category: \.home, level: .fault)
        }
        ///
        return collectionViewsection
    }
    //
    private func makeCategoriesSection(from section: Section) -> CompositionalLayoutableSection {
        let collectionViewsection = HomeCategoriesCollectionViewSection()
        ///
        if let categories = section.categories {
            collectionViewsection.update(collectionView, withItems: categories)
        } else {
            Logger.log("could not wrap categories this may be an error from the backend", category: \.home, level: .fault)
        }
        ///
        if let title = section.title {
            collectionViewsection.configure(owner: self, topViewModel: .init(label: title))
        }
        ///
        return collectionViewsection
    }
    //
    private func makeProductsSection(from section: Section) -> CompositionalLayoutableSection {
        let collectionViewsection = ProductsCollectionViewSection()
        ///
        if let categories = section.products {
            collectionViewsection.update(collectionView, withItems: categories)
        } else {
            Logger.log("could not wrap Products this may be an error from the backend", category: \.home, level: .fault)
        }
        ///
        if let title = section.title {
            collectionViewsection.configure(owner: self, topViewModel: .init(label: title, button: L10n.App.seeAll, action: { }))
        }
        ///
        return collectionViewsection
    }
    //
    private func makeOffersSection(from section: Section) -> CompositionalLayoutableSection {
        let collectionViewsection = OfferCollectionViewSection()
        ///
        if let offers = section.offers {
            collectionViewsection.update(collectionView, withItems: offers)
        } else {
            Logger.log("could not wrap Offers this may be an error from the backend", category: \.home, level: .fault)
        }
        ///
        return collectionViewsection
    }
    ///
    private func makeNewsSection(from section: Section) -> CompositionalLayoutableSection {
        let collectionViewsection = NewsCollectionViewSection()
        ///
        if let news = section.news {
            collectionViewsection.update(collectionView, withItems: news)
        } else {
            Logger.log("could not wrap News this may be an error from the backend", category: \.home, level: .fault)
        }
        ///
        if let title = section.title {
            collectionViewsection.configure(owner: self,
                                            topViewModel: .init(label: title),
                                            bottomViewModel: .init(title: "See All News", target: self,
                                                                   action: #selector(newsSectionBottomViewAction(_:))))
        }
        ///
        return collectionViewsection
    }
}

// MARK: - Actions
private extension HomeViewController {
    @objc private func newsSectionBottomViewAction(_ sender: Any) {
        print("here")
        LoginManager.shared.checkLogin(loginHandeler: { [unowned self] in
            navigationController?.pushViewController(AllNewsViewController(), animated: true)
        })
    }
}
