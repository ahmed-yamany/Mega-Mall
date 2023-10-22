import UIKit
import Factory

class ResetPasswordViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var emailTextFieldView: OnboardingTextField!
    @IBOutlet weak var resetButton: FullButton!
    //
    // MARK: Properties
    @Injected(\ViewModelContainer.resetPassword) var viewModel: ResetPasswordViewModel
    //
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
        viewModel.$isValid.sink { [unowned self] isValid in
            resetButton.isEnabled = isValid
        }.store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Private Handlers
private extension ResetPasswordViewController {}
