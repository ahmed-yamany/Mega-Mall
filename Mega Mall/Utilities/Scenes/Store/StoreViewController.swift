import UIKit
import Extensions
import CompositionalLayoutableSection

class StoreViewController: UICollectionViewController, CompositionalLayoutProvider {
    // MARK: Outlets
    //
    // MARK: - Properties
    private let viewModel: StoreViewModel
    ///
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    ///
    lazy var delegare = CompositionalLayoutDelegate(provider: self)
    lazy var dataSource = CompositionalLayoutDataSource(provider: self)
    //
    // MARK: - Init
    init(viewModel: StoreViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: .init())
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        ///
        collectionView.delegate = delegare
        collectionView.dataSource = dataSource
        ///
        let section = StoreDetailCollectionViewSection()
        section.update(collectionView, withItems: [viewModel.store])
        section.configure(owner: self)
        compositionalLayoutSections.append(section)
        ///
        let productsSection = VerticalProductsCollectionViewSection()
        productsSection.update(collectionView, withItems: viewModel.store.products)
        productsSection.configure(owner: self)
        compositionalLayoutSections.append(productsSection)
        ///
        collectionView.updateCollectionViewCompositionalLayout(for: self)
    }
}
//
// MARK: - Actions
extension StoreViewController {}
//
// MARK: - Configurations
private extension StoreViewController {
    func configureViews() {
        view.backgroundColor = .megaPrimaryPureWhite
        collectionView.backgroundColor = .megaPrimaryPureWhite
        navigationItem.addTitleLabel(with: "Seller Info", color: .megaPrimaryNavyBlack, font: .h3)
        configureLeftBartButtonItems()
    }
    func configureLeftBartButtonItems() {
        guard let navigationController = navigationController as? MegaNavigationController else {
            Logger.log("Home Navigation Controller must be of type Mega", category: \.home, level: .fault)
            return
        }
        navigationController.addShopingCartItem()
    }
}
//
// MARK: - Private Handlers
private extension StoreViewController {}
