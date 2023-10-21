import UIKit

class EmailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var descriptionView: DescriptionView!
    //
    // MARK: Properties
    private let viewModel: EmailViewModelType
    //
    // MARK: Init
    init(viewModel: EmailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}
//
// MARK: - Actions
extension EmailViewController {}
//
// MARK: - Configurations
extension EmailViewController {
    private func configureViews() {
        configureDescriptionView()
    }
    private func configureDescriptionView() {
        descriptionView.configure(with: .init(title: L10n.Onboarding.Register.Email.Decription.title,
                                              subtitle: L10n.Onboarding.Register.Email.Decription.subtitle))
    }
}
//
// MARK: - Private Handlers
private extension EmailViewController {}
