import UIKit
import Factory

class RegisterViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak private(set) var descriptionView: DescriptionView!
    @IBOutlet weak private(set) var emailTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var continueButton: FullButton!
    //
    // MARK: Properties
    private(set) var viewModel: RegisterViewModelType
    var emailViewModel: OnboardingTextField.ViewModel = .init(model:
            .init(label: L10n.Onboarding.Register.Email.label,
                  placeholder: L10n.Onboarding.Register.Email.placeholder))
    // MARK: - Init
    init() {
        self.viewModel = RegisterViewModel(emailViewModel: emailViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("failed to inirialder Verification View Controller from coder")
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
extension RegisterViewController {
    @IBAction func continueButtonTapped(_ sender: FullButton) {
        let verificationViewModel = VerificationViewModel(email: viewModel.emailViewModel.text, type: .register)
        navigationController?.pushViewController(VerificationViewController(viewModel: verificationViewModel), animated: true)
    }
}
//
// MARK: - Configurations
extension RegisterViewController {
    private func configureViews() {
        descriptionView.configure(with: .init(title: L10n.Onboarding.Register.Email.Decription.title,
                                              subtitle: L10n.Onboarding.Register.Email.Decription.subtitle))
        emailTextFieldView.configure(with: viewModel.emailViewModel)
        emailTextFieldView.textfield.keyboardType = .emailAddress
        viewModel.enableButton
            .assign(to: \.isEnabled, on: continueButton)
            .store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Private Handlers
private extension RegisterViewController {}
