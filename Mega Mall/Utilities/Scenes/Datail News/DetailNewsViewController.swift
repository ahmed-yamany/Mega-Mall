import UIKit
import Extensions
import CompositionalLayoutableSection

class DetailNewsViewController: UICollectionViewController, CompositionalLayoutProvider {
    // MARK: - Properties
    private(set) var viewModel: DetailNewsViewModelType
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    private(set) lazy var delegate = CompositionalLayoutDelegate(provider: self)
    private(set) lazy var dataSource = CompositionalLayoutDataSource(provider: self)
    //
    // MARK: - Init
    init(viewModel: DetailNewsViewModelType) {
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        TabBarViewModel.shared.tabBarIsHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        ///
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        //
        let section = DetailNewsCollectionViewSection()
        section.update(collectionView, withItems: [viewModel.news])
        compositionalLayoutSections.append(section)
        // every news object will has an array with other news
        // i just mocking it by giving the current news
        let allNewsSection = NewsCollectionViewSection()
        allNewsSection.update(collectionView, withItems: [viewModel.news, viewModel.news])
        allNewsSection.configure(owner: self,
                                 topViewModel: .init(label: "Other News"),
                                 bottomViewModel: .init(title: "See All News", target: self,
                                                        action: #selector(newsSectionBottomViewAction(_:))))
        compositionalLayoutSections.append(allNewsSection)
        //
        collectionView.updateCollectionViewCompositionalLayout(for: self)
    }
}
//
// MARK: - Actions
private extension DetailNewsViewController {
    @objc private func newsSectionBottomViewAction(_ sender: Any) {
        LoginManager.shared.checkLogin(loginHandler: { [unowned self] in
            if let navigationController {
                let allNewsVC = Coordinator.shared.allNews()
                navigationController.pushViewController(allNewsVC, animated: true)
            } else {
                Logger.log("Failed to wrap navigationController", category: \.default, level: .fault)
            }
        })
    }
}//
// MARK: - Configurations
extension DetailNewsViewController {
    private func configureViews() {
        view.backgroundColor = .megaPrimaryPureWhite
        collectionView.backgroundColor = .megaPrimaryPureWhite
        configureNavigationItem()
    }
    private func configureNavigationItem() {
        navigationItem.addTitleLabel(with: L10n.News.Detail.title, color: .megaPrimaryNavyBlack, font: .h3)
        let image = UIImage(systemName: "arrowshape.turn.up.forward")?.withTintColor(.megaPrimaryNavyBlack)
        let item = UIBarButtonItem(image: image, style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [item]
    }
}
//
// MARK: - Private Handlers
private extension DetailNewsViewController {}
