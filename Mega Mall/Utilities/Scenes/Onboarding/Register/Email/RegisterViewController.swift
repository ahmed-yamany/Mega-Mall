import UIKit
import Extensions

class RegisterViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak private(set) var descriptionView: DescriptionView!
    @IBOutlet weak private(set) var emailTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var continueButton: PrimaryButton!
    //
    // MARK: Properties
    private(set) var viewModel: RegisterViewModelType!
    private lazy var descriptionViewModel = createDescriptionView()
    private lazy var emailViewModel = createEmailViewModel()
    //
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RegisterViewModel(emailViewModel: emailViewModel)
        configureViews()
    }
}
//
// MARK: - Actions
extension RegisterViewController {
    @IBAction func continueButtonTapped(_ sender: PrimaryButton) {
        navigateToVerification()
    }
}
//
// MARK: - Configurations
extension RegisterViewController {
    private func configureViews() {
        descriptionView.configure(with: descriptionViewModel)
        //
        emailTextFieldView.configure(with: viewModel.emailViewModel)
        emailTextFieldView.textfield.keyboardType = .emailAddress
        //
        viewModel.enableButton
            .assign(to: \.isEnabled, on: continueButton)
            .store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Private Handlers
private extension RegisterViewController {
    func createDescriptionView() -> DescriptionView.Model {
        let title = L10n.Onboarding.Register.Email.Decription.title
        let subtitle = L10n.Onboarding.Register.Email.Decription.subtitle
        return .init(title: title, subtitle: subtitle)
    }
    //
    func createEmailViewModel() -> OnboardingTextField.ViewModel {
        let title = L10n.Onboarding.Register.Email.label
        let placeholder = L10n.Onboarding.Register.Email.placeholder
        return .init(model: .init(label: title, placeholder: placeholder))
    }
    //
    func navigateToVerification() {
        if let navigationController {
            let verificationVM = VerificationViewModel(email: viewModel.emailViewModel.text, type: .register)
            let verificationVC = Coordinator.shared.verification(verificationVM)
            navigationController.pushViewController(verificationVC, animated: true)
        } else {
            Logger.log("Failed to wrap navigation View", category: \.default, level: .fault)
        }
    }
}
