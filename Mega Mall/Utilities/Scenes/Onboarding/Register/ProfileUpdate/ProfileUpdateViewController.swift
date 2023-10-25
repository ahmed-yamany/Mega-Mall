import UIKit

class ProfileUpdateViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var fullNameTextFieldView: OnboardingTextField!
    @IBOutlet weak var passwordTextFieldView: OnboardingTextField!
    @IBOutlet weak var referalCodeTextFieldView: OnboardingTextField!
    @IBOutlet weak var confirmationButton: FullButton!
    // MARK: Properties
    private let viewModel: ProfileUpdateViewModel
    private let fullNameViewModel = OnboardingTextField.ViewModel(model:
            .init(label: L10n.Onboarding.UpdateProfile.FullName.label,
                  placeholder: L10n.Onboarding.UpdateProfile.FullName.placeholder))
    private let passwordViewModel = OnboardingTextField.ViewModel(model:
            .init(label: L10n.Onboarding.UpdateProfile.Password.label,
                  placeholder: L10n.Onboarding.UpdateProfile.Password.placeholder,
                  securedTextField: true))
    private let referalCodeViewModel = OnboardingTextField.ViewModel(model:
            .init(label: L10n.Onboarding.UpdateProfile.ReferalCode.label,
                  placeholder: L10n.Onboarding.UpdateProfile.ReferalCode.placeholder))
    // MARK: Init
    init() {
        self.viewModel = ProfileUpdateViewModel(fullNameViewModel: fullNameViewModel,
                                                passwordViewModel: passwordViewModel,
                                                referalCodeViewModel: referalCodeViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}
// MARK: - Actions
extension ProfileUpdateViewController {}
// MARK: - Configurations
extension ProfileUpdateViewController {
    private func configureViews() {
        descriptionView.configure(with: .init(title: L10n.Onboarding.UpdateProfile.Decription.title,
                                              subtitle: L10n.Onboarding.UpdateProfile.Decription.subtitle))
        fullNameTextFieldView.configure(with: fullNameViewModel)
        passwordTextFieldView.configure(with: passwordViewModel)
        referalCodeTextFieldView.configure(with: referalCodeViewModel)
        viewModel.enableButton
            .assign(to: \.isEnabled, on: confirmationButton)
            .store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Private Handlers
private extension ProfileUpdateViewController {}
