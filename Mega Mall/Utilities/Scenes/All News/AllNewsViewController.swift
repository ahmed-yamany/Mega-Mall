import UIKit
import Extensions
import CompositionalLayoutableSection

class AllNewsViewController: UIViewController, CompositionalLayoutProvider {
    // MARK: - Outlets
    //
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    private(set) var viewModel: AllNewsViewModel!
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    private(set) lazy var delegate = CompositionalLayoutDelegate(provider: self)
    private(set) lazy var datasource = CompositionalLayoutDataSource(provider: self)
    //
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
    private func setupViewModel() {
        viewModel = AllNewsViewModel()
        viewModel.getNews().sink { [unowned self] news in
            let seciton = NewsCollectionViewSection()
            //
            seciton.update(collectionView, withItems: news)
            seciton.configure(owner: self)
            compositionalLayoutSections.append(seciton)
            //
            collectionView.updateCollectionViewCompositionalLayout(for: self)
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
