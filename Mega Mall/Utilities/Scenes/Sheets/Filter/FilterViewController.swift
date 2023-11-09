import UIKit

class FilterViewController: SheetViewController {
    // MARK: Views
    var filterView: FilterView!
    //
    // MARK: - Properties
    private let viewModel: FilterViewModel
    //
    // MARK: - Init
    override init() {
        self.viewModel = FilterViewModel.shared
        super.init()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterView = FilterView()
        filterView.configure(with: viewModel)
        configureViews()
    }
}
//
// MARK: - Actions
extension FilterViewController {}
//
// MARK: - Configurations
extension FilterViewController {
    private func configureViews() {
        title = "Filter & Sorting"
        addChild(filterView)
    }
}
//
// MARK: - Private Handlers
private extension FilterViewController {}
