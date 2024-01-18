import UIKit
import ViewAnimator
import Extensions
import CompositionalLayoutableSection
import Combine

class HomeViewController: UIViewController, CompositionalLayoutProvider {
    // MARK: - Outlets
    //
    @IBOutlet weak private(set) var searchTextField: SearchTextField!
    @IBOutlet weak private(set) var collectionView: UICollectionView!
    // MARK: - Properties
    private(set) var viewModel: HomeViewModel!
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    private(set) lazy var delegate = CompositionalLayoutDelegate(provider: self)
    private(set) lazy var datasource = CompositionalLayoutDataSource(provider: self)
    private lazy var sectionFactory = CollectionViewSectionFactory(owner: self)
    
    let segmentTitle = ["Sort", "Filter", "Arrange"]
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        //
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
        //
        setupViewModel()
    }
    //
    private func setupViewModel() {
        self.viewModel = HomeViewModel()
        //
        viewModel.getHome().sink { [unowned self] home in
            for section in home.sections {
                let collectionViewSection = sectionFactory.makeCompositionalLayoutableSection(from: section)
                compositionalLayoutSections.append(collectionViewSection)
            }
            // this must be called after adding all sections to compositionalLayoutSections
            collectionView.updateCollectionViewCompositionalLayout(for: self)
        }
        .store(in: &viewModel.cancellableSet)
    }
}

// MARK: - Configurations
private extension HomeViewController {
    func configureViews() {
        configureNavigationItem()
    }
    //
    func configureNavigationItem() {
        navigationItem.addTitleLabel(with: L10n.App.name, color: .megaPrimaryBlueOcean, font: .h2)
        configureRightBartButtonItems()
    }
    //
    func configureRightBartButtonItems() {
        guard let navigationController = navigationController as? MegaNavigationController else {
            Logger.log("Home Navigation Controller must be of type Mega", category: \.home, level: .fault)
            return
        }
        navigationController.addShopingCartItem()
        navigationController.addNotificationItem()
    }
}
