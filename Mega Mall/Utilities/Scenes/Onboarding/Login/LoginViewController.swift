import UIKit
import Extensions

class LoginViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak private(set) var descriptionView: DescriptionView!
    @IBOutlet weak private(set) var emailTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var passwordTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var signinButton: PrimaryButton!
    // MARK: - Properties
    var viewModel: LoginViewModelType!
    private lazy var descriptionViewModel = createDescriptionViewModel()
    private lazy var emailViewModel = createEmailViewModel()
    private lazy var passwordViewModel = createPasswordViewModel()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(emailViewModel: emailViewModel, passwordViewModel: passwordViewModel)
        configureViews()
    }
}
// MARK: - Actions
//
extension LoginViewController {
    @IBAction private func signinButtonTapped(_ sender: PrimaryButton) {
        performLogin()
    }
    //
    @IBAction private func forgotPasswordTapped(_ sender: LabelButton) {
        navigateToForgotPassword()
    }
    //
    @IBAction private func signupButtonTapped(_ sender: LabelButton) {
        navigateToRegistration()
    }
}
// MARK: - Configurations
//
private extension LoginViewController {
    func configureViews() {
        descriptionView.configure(with: descriptionViewModel)
        ///
        emailTextFieldView.configure(with: viewModel.emailViewModel)
        passwordTextFieldView.configure(with: viewModel.passwordViewModel)
        emailTextFieldView.textfield.keyboardType = .emailAddress
        ///
        enableDisableButton()
    }
}
// MARK: - Private Handlers
//
private extension LoginViewController {
    /// Creates the view model for the description view.
    func createDescriptionViewModel() -> DescriptionView.Model {
        let title = L10n.Onboarding.Login.Decription.title
        let subtitle = L10n.Onboarding.Login.Decription.subtitle
        return DescriptionView.Model(title: title, subtitle: subtitle)
    }
    /// Creates the view model for the email text field.
    func createEmailViewModel() -> OnboardingTextField.ViewModel {
        let title = L10n.Onboarding.Login.Email.label
        let placeholder = L10n.Onboarding.Login.Email.placeholder
        return OnboardingTextField.ViewModel(model: .init(label: title, placeholder: placeholder))
    }
    /// Creates the view model for the password text field.
    func createPasswordViewModel() -> OnboardingTextField.ViewModel {
        let title = L10n.Onboarding.Login.Password.label
        let placeholder = L10n.Onboarding.Login.Password.placeholder
        return OnboardingTextField.ViewModel(model: .init(label: title, placeholder: placeholder, securedTextField: true))
    }
    /// Enables or disables the "Sign In" button based on the view model's state.
    func enableDisableButton() {
        viewModel.enableButton
            .assign(to: \.isEnabled, on: signinButton)
            .store(in: &viewModel.cancellableSet)
    }
    //
    func performLogin() {
        viewModel.performLogin()
            .sink(receiveValue: { [unowned self] isLoggedIn in
                if isLoggedIn {
                    navigateToTabBar()
                } else {
                    // Handle login failure
                }
            })
            .store(in: &viewModel.cancellableSet)
    }
    //
    func navigateToTabBar() {
        guard let mainWindow = UIApplication.shared.mainWindow else {
            Logger.log("failed to wrap mainWindow", category: \.default, level: .fault)
            return
        }
        let tabBarViewModel = TabBarViewModel.shared
        mainWindow.rootViewController = Coordinator.shared.tabbar(tabBarViewModel)
        tabBarViewModel.isLogin = true
    }
    //
    func navigateToForgotPassword() {
        if let navigationController {
            let forgotPasswordVC = Coordinator.shared.forgotPassword()
            navigationController.pushViewController(forgotPasswordVC, animated: true)
        } else {
            Logger.log("Failed to wrap navigationController", category: \.default, level: .fault)
        }
    }
    //
    func navigateToRegistration() {
        if let navigationController {
            let registerVC = Coordinator.shared.register()
            navigationController.pushViewController(registerVC, animated: true)
        } else {
            Logger.log("Failed to wrap navigationController", category: \.default, level: .fault)
        }
    }
}
