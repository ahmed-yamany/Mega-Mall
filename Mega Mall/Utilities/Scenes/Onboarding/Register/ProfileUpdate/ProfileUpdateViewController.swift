import UIKit

class ProfileUpdateViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak private(set) var descriptionView: DescriptionView!
    @IBOutlet weak private(set) var fullNameTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var passwordTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var referalCodeTextFieldView: OnboardingTextField!
    @IBOutlet weak private(set) var confirmationButton: PrimaryButton!
    // MARK: Properties
    private(set) var viewModel: ProfileUpdateViewModel!
    private lazy var descriptionViewModel = createDescriptionViewModel()
    private lazy var fullNameViewModel = createfullNameViewModel()
    private lazy var passwordViewModel = createPasswordViewModel()
    private lazy var referalCodeViewModel = createreferalCodeViewModel()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileUpdateViewModel(fullNameViewModel: fullNameViewModel,
                                           passwordViewModel: passwordViewModel,
                                           referalCodeViewModel: referalCodeViewModel)
        configureViews()
    }
}
// MARK: - Actions
extension ProfileUpdateViewController {}
// MARK: - Configurations
extension ProfileUpdateViewController {
    private func configureViews() {
        descriptionView.configure(with: descriptionViewModel)
        ///
        fullNameTextFieldView.configure(with: fullNameViewModel)
        passwordTextFieldView.configure(with: passwordViewModel)
        referalCodeTextFieldView.configure(with: referalCodeViewModel)
        ///
        viewModel.enableButton
            .assign(to: \.isEnabled, on: confirmationButton)
            .store(in: &viewModel.cancellableSet)
    }
}
//
// MARK: - Private Handlers
private extension ProfileUpdateViewController {
    func createDescriptionViewModel() -> DescriptionView.Model {
        let title = L10n.Onboarding.UpdateProfile.Decription.title
        let subtitle = L10n.Onboarding.UpdateProfile.Decription.subtitle
        return .init(title: title, subtitle: subtitle)
    }
    //
    func createfullNameViewModel() -> OnboardingTextField.ViewModel {
        let title = L10n.Onboarding.UpdateProfile.FullName.label
        let placholder = L10n.Onboarding.UpdateProfile.FullName.placeholder
        return .init(model: .init(label: title, placeholder: placholder))
    }
    //
    func createPasswordViewModel() -> OnboardingTextField.ViewModel {
        let title = L10n.Onboarding.UpdateProfile.Password.label
        let placeholder = L10n.Onboarding.UpdateProfile.Password.placeholder
        return .init(model: .init(label: title, placeholder: placeholder, securedTextField: true))
    }
    //
    func createreferalCodeViewModel() -> OnboardingTextField.ViewModel {
        let title = L10n.Onboarding.UpdateProfile.ReferalCode.label
        let subtitle = L10n.Onboarding.UpdateProfile.ReferalCode.placeholder
        return .init(model: .init(label: title, placeholder: subtitle))
    }
}
