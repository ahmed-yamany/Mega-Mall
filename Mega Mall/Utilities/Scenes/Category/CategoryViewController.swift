import UIKit
import CompositionalLayoutableSection

class CategoryViewController: UIViewController, CompositionalLayoutProvider {
    // MARK: - Outlets
    //
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: Properties
    private let viewModel: CategoryViewModel
    ///
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    ///
    lazy var delegte = CompositionalLayoutDelegate(provider: self)
    lazy var dataSource = CompositionalLayoutDataSource(provider: self)
    //
    // MARK: - Init
    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        TabBarViewModel.shared.tabBarIsHidden = false
    }
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        //
        collectionView.delegate = delegte
        collectionView.dataSource = dataSource
        //
        viewModel.getProducts().sink { [unowned self] products in
            let collectionViewsection = VerticalProductsCollectionViewSection()
            compositionalLayoutSections.append(collectionViewsection)
            //
            collectionViewsection.update(collectionView, withItems: products)
            collectionViewsection.configure(owner: self,
                                            bottomViewModel: .init(title: "Filter & Sorting",
                                                                   target: self, action: #selector(filterButtonAction)))
            //
            collectionView.updateCollectionViewCompositionalLayout(for: self)
        }.store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Actions
extension CategoryViewController {
    @objc private func filterButtonAction() {
        FilterViewController().presentSheet()
    }
}
//
// MARK: - Configurations
extension CategoryViewController {
    private func configureViews() {
        navigationItem.addTitleLabel(with: "Category", color: .megaPrimaryNavyBlack)
        configureRightBartButtonItems()
    }
    ///
    private func configureRightBartButtonItems() {
        guard let navigationController = navigationController as? MegaNavigationController else {
            Logger.log("Category Navigation Controller must be of type Mega", category: \.home, level: .fault)
            return
        }
        navigationController.addShopingCartItem()
    }
}
//
// MARK: - Private Handlers
private extension CategoryViewController {}
