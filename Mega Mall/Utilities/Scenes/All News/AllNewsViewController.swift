import UIKit
import Extensions
import CompositionalLayoutableSection

class AllNewsViewController: UIViewController, CompositionalLayoutProvider {
    // MARK: - Outlets
    //
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    private let viewModel: AllNewsViewModel
    ///
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    ///
    lazy var delegate = CompositionalLayoutDelegate(provider: self)
    lazy var datasource = CompositionalLayoutDataSource(provider: self)
    //
    // MARK: - Init
    init() {
        self.viewModel = AllNewsViewModel()
        super.init(nibName: nil, bundle: nil)
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
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
        viewModel.getNews().sink { [unowned self] news in
            let seciton = NewsCollectionViewSection()
            seciton.update(collectionView, withItems: news)
            seciton.configure(owner: self)
            compositionalLayoutSections.append(seciton)
            collectionView.updatecollectionViewCompositionalLayout(for: self)
        }.store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Actions
extension AllNewsViewController {}
//
// MARK: - Configurations
extension AllNewsViewController {
    private func configureViews() {
        navigationItem.addTitleLabel(with: L10n.News.title, color: .megaPrimaryNavyBlack, font: .h3)
    }
}
//
// MARK: - Private Handlers
private extension AllNewsViewController {}
