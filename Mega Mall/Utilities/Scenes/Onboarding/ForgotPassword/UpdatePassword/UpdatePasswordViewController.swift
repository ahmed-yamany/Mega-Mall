import UIKit

class UpdatePasswordViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var passwordTextFieldView: OnboardingTextField!
    @IBOutlet weak var confirmPasswordTextFieldView: OnboardingTextField!
    @IBOutlet weak var updateButton: PrimaryButton!
    // MARK: - Properties
    private(set) var viewModel: UpdatePasswordViewModel!
    private lazy var descriptionViewModel = createDescriptionViewModel()
    private lazy var passwordViewModel = createPasswordViewModel()
    private lazy var confirmPasswordViewModel = createConfirmPasswordViewModel()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UpdatePasswordViewModel(passwordViewModel: passwordViewModel,
                                            confirmPasswordViewModel: confirmPasswordViewModel)
        configureViews()
    }
}
//
// MARK: - Actions
extension UpdatePasswordViewController {}
//
// MARK: - Configurations
extension UpdatePasswordViewController {
    private func configureViews() {
        descriptionView.configure(with: descriptionViewModel)
        //
        passwordTextFieldView.configure(with: passwordViewModel)
        confirmPasswordTextFieldView.configure(with: confirmPasswordViewModel)
        //
        viewModel.enableButton
            .assign(to: \.isEnabled, on: updateButton)
            .store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Private Handlers
private extension UpdatePasswordViewController {
    func createDescriptionViewModel() -> DescriptionView.Model {
        let title = L10n.Onboarding.UpdatePassword.Decription.title
        let subtitle = L10n.Onboarding.UpdatePassword.Decription.subtitle
        return .init(title: title, subtitle: subtitle)
    }
    //
    func createPasswordViewModel() -> OnboardingTextField.ViewModel {
        let title = L10n.Onboarding.UpdatePassword.Password.label
        let placeholder = L10n.Onboarding.UpdatePassword.Password.placeholder
        return OnboardingTextField.ViewModel(model: .init(label: title, placeholder: placeholder, securedTextField: true))
    }
    //
    func createConfirmPasswordViewModel() -> OnboardingTextField.ViewModel {
        let title = L10n.Onboarding.UpdatePassword.ConfirmPassword.label
        let placeholder = L10n.Onboarding.UpdatePassword.ConfirmPassword.placeholder
        return OnboardingTextField.ViewModel(model: .init(label: title, placeholder: placeholder, securedTextField: true))
    }
}
