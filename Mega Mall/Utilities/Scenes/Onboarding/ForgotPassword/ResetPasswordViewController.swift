import UIKit
import Factory

class ResetPasswordViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak private(set) var descriptionView: DescriptionView!
    @IBOutlet weak private(set) var emailTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var resetButton: FullButton!
    // MARK: Properties
    private(set) var viewModel: ResetPasswordViewModelType
    var emailViewModel: OnboardingTextField.ViewModel = .init(model:
            .init(label: L10n.Onboarding.ForgotPassword.Email.label,
                  placeholder: L10n.Onboarding.ForgotPassword.Email.placeholder))

    // MARK: - Init
    init() {
        self.viewModel = ResetPasswordViewModel(emailViewModel: emailViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("failed to inirialder Verification View Controller from coder")
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}
//
// MARK: - Actions
extension ResetPasswordViewController {}
//
// MARK: - Configurations
extension ResetPasswordViewController {
    private func configureViews() {
        descriptionView.configure(with: .init(title: L10n.Onboarding.ForgotPassword.Decription.title,
                                              subtitle: L10n.Onboarding.ForgotPassword.Decription.subtitle))
        emailTextFieldView.configure(with: viewModel.emailViewModel)
        emailTextFieldView.textfield.keyboardType = .emailAddress
        viewModel.enableButton
            .assign(to: \.isEnabled, on: resetButton)
            .store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Private Handlers
private extension ResetPasswordViewController {}
