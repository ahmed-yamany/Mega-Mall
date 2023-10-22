import UIKit
import Factory

class RegisterEmailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var emailTextFieldView: OnboardingTextField!
    @IBOutlet weak var continueButton: FullButton!
    //
    // MARK: Properties
    @Injected(\ViewModelContainer.registerEmail) var viewModel: RegisterEmailViewModel
    //
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}
//
// MARK: - Actions
extension RegisterEmailViewController {}
//
// MARK: - Configurations
extension RegisterEmailViewController {
    private func configureViews() {
        descriptionView.configure(with: .init(title: L10n.Onboarding.Register.Email.Decription.title,
                                              subtitle: L10n.Onboarding.Register.Email.Decription.subtitle))
        emailTextFieldView.configure(with: viewModel.emailViewModel)
        viewModel.$isValid.sink { [unowned self] isValid in
            continueButton.isEnabled = isValid
        }.store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Private Handlers
private extension RegisterEmailViewController {}
