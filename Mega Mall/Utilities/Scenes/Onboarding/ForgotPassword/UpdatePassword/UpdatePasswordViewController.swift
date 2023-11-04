import UIKit

class UpdatePasswordViewController: UIViewController {
    // MARK: Outlets
    //
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var passwordTextFieldView: OnboardingTextField!
    @IBOutlet weak var confirmPasswordTextFieldView: OnboardingTextField!
    @IBOutlet weak var updateButton: PrimaryButton!
    // MARK: Properties
    //
    private let viewModel: UpdatePasswordViewModel
    private let passwordViewModel = OnboardingTextField.ViewModel(model:
            .init(label: L10n.Onboarding.UpdatePassword.Password.label,
                  placeholder: L10n.Onboarding.UpdatePassword.Password.placeholder,
                  securedTextField: true))
    private let confirmPasswordViewModel = OnboardingTextField.ViewModel(model:
            .init(label: L10n.Onboarding.UpdatePassword.ConfirmPassword.label,
                  placeholder: L10n.Onboarding.UpdatePassword.ConfirmPassword.placeholder,
                  securedTextField: true))
    // MARK: Init
    //
    init() {
        viewModel = UpdatePasswordViewModel(passwordViewModel: passwordViewModel,
                                            confirmPasswordViewModel: confirmPasswordViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
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
        descriptionView.configure(with: .init(title: L10n.Onboarding.UpdatePassword.Decription.title,
                                              subtitle: L10n.Onboarding.UpdatePassword.Decription.subtitle))
        passwordTextFieldView.configure(with: passwordViewModel)
        confirmPasswordTextFieldView.configure(with: confirmPasswordViewModel)
        viewModel.enableButton
            .assign(to: \.isEnabled, on: updateButton)
            .store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Private Handlers
private extension UpdatePasswordViewController {}
