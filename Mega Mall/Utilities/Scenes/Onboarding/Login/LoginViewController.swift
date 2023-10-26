import UIKit
import Factory

class LoginViewController: UIViewController {
    // MARK: - Outlets
    //
    @IBOutlet weak private(set) var descriptionView: DescriptionView!
    @IBOutlet weak private(set) var emailTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var passwordTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var signinButton: FullButton!
    // MARK: - Properties
    //
    var viewModel: LoginViewModelType
    private let descriptionViewModel = DescriptionView.Model(title: L10n.Onboarding.Login.Decription.title,
                                                             subtitle: L10n.Onboarding.Login.Decription.subtitle)
    private let emailViewModel = OnboardingTextField.ViewModel(model:
            .init(label: L10n.Onboarding.Login.Email.label,
                  placeholder: L10n.Onboarding.Login.Email.placeholder))
    private let passwordViewModel = OnboardingTextField.ViewModel(model:
            .init(label: L10n.Onboarding.Login.Password.label,
                  placeholder: L10n.Onboarding.Login.Password.placeholder,
                  securedTextField: true))
    // MARK: - Init
    init() {
        viewModel = LoginViewModel(emailViewModel: emailViewModel, passwordViewModel: passwordViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("failed to inirialder Verification View Controller from coder")
    }
    // MARK: - Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        enableDisableButton()
    }
}
// MARK: - Actions
//
extension LoginViewController {
    @IBAction private func forgotPasswordTapped(_ sender: LabelButton) {
        navigationController?.pushViewController(ResetPasswordViewController(), animated: true)
    }
    @IBAction private func signupButtonTapped(_ sender: LabelButton) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
// MARK: - Configurations
//
extension LoginViewController {
    private func configureViews() {
        descriptionView.configure(with: descriptionViewModel)
        emailTextFieldView.configure(with: viewModel.emailViewModel)
        passwordTextFieldView.configure(with: viewModel.passwordViewModel)
        emailTextFieldView.textfield.keyboardType = .emailAddress
    }
}
// MARK: - Private Handlers
//
private extension LoginViewController {
    private func enableDisableButton() {
        viewModel.enableButton
            .assign(to: \.isEnabled, on: signinButton)
            .store(in: &viewModel.cancellableSet)
    }
}
