import UIKit
import Factory

class LoginViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var emailTextFieldView: OnboardingTextField!
    @IBOutlet weak var passwordTextFieldView: OnboardingTextField!
    @IBOutlet weak var signinButton: FullButton!
    // MARK: Properties
    @Injected(\ViewModelContainer.login) var viewModel: LoginViewModel
    //
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        viewModel.$isValid.sink { [unowned self] isValid in
            signinButton.isEnabled = isValid
        }.store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Actions
extension LoginViewController {}
//
// MARK: - Configurations
extension LoginViewController {
    private func configureViews() {
        descriptionView.configure(with: .init(title: L10n.Onboarding.Login.Decription.title,
                                              subtitle: L10n.Onboarding.Login.Decription.subtitle))
        emailTextFieldView.configure(with: viewModel.emailViewModel)
        passwordTextFieldView.configure(with: viewModel.passwordViewModel)
    }
}
//
// MARK: - Private Handlers
private extension LoginViewController {}
