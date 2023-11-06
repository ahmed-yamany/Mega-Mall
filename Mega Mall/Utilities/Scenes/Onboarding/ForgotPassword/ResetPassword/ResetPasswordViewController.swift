import UIKit
import Extensions

class ResetPasswordViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak private(set) var descriptionView: DescriptionView!
    @IBOutlet weak private(set) var emailTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var resetButton: PrimaryButton!
    // MARK: - Properties
    private(set) var viewModel: ResetPasswordViewModel!
    private lazy var descriptionViewModel = createDescriptionViewModel()
    private lazy var emailViewModel = createEmailViewModel()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ResetPasswordViewModel(emailViewModel: emailViewModel)
        configureViews()
    }
}
//
// MARK: - Actions
private extension ResetPasswordViewController {
    @IBAction func resetButtonTapped(_ sender: PrimaryButton) {
        navigateToVerification()
    }
}
//
// MARK: - Configurations
private extension ResetPasswordViewController {
    func configureViews() {
        descriptionView.configure(with: descriptionViewModel)
        ///
        emailTextFieldView.configure(with: viewModel.emailViewModel)
        emailTextFieldView.textfield.keyboardType = .emailAddress
        ///
        viewModel.enableButton
            .assign(to: \.isEnabled, on: resetButton)
            .store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Private Handlers
private extension ResetPasswordViewController {
    /// creates Model for Description View
    func createDescriptionViewModel() -> DescriptionView.Model {
        let title = L10n.Onboarding.ForgotPassword.Decription.title
        let subtitle = L10n.Onboarding.ForgotPassword.Decription.subtitle
        return .init(title: title, subtitle: subtitle)
    }
    /// create ViewModel for email Text field
    func createEmailViewModel() -> OnboardingTextField.ViewModel {
        let title = L10n.Onboarding.ForgotPassword.Email.label
        let placeholder = L10n.Onboarding.ForgotPassword.Email.placeholder
        return .init(model: .init(label: title, placeholder: placeholder))
    }
    //
    func navigateToVerification() {
        if let navigationController {
            let verificationViewModel = VerificationViewModel(email: emailViewModel.text, type: .forgotPassword)
            let verificationViewController = Coordinator.shared.verification(verificationViewModel)
            ///
            navigationController.pushViewController(verificationViewController, animated: true)
        } else {
            Logger.log("failed to wrap navigationController", category: \.default, level: .fault)
        }
    }
}
