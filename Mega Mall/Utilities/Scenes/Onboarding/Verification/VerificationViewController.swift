import UIKit
import Factory
import Extensions

class VerificationViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak private(set) var descriptionView: DescriptionView!
    @IBOutlet weak private(set) var otpTextfField: OTPTextField!
    @IBOutlet weak private(set) var continueButton: PrimaryButton!
    //
    // MARK: - Properties
    private(set) var viewModel: VerificationViewModel
    // MARK: - Init
    init(viewModel: VerificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    ///
    required init?(coder: NSCoder) {
        fatalError("failed to inirialder Verification View Controller from coder")
    }
    // MARK: - Lifecycle
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        ///
        subscribeToOTPCode()
    }
}
extension VerificationViewController: OTPTextFieldDataSource {
    func createDigitLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  .h3
        label.text = "_"
        label.backgroundColor = .megaSecondarySoftGray
        label.layerCornerRadius = 8
        return label
    }
}
//
// MARK: - Actions
extension VerificationViewController {
    @IBAction func continueButtonTapped(_ sender: PrimaryButton) {
        let viewController = switch viewModel.verificationType {
                             case .register: Coordinator.shared.profileUpdate()
                             case .forgotPassword: Coordinator.shared.updatePassword() }
        ///
        navigationController?.pushViewController(viewController, animated: true)
    }
}
//
// MARK: - Configurations
extension VerificationViewController {
    private func configureViews() {
        let descriptionViewSubtitle = "\(L10n.Onboarding.Verification.Decription.subtitle) \(viewModel.email)"
        descriptionView.configure(with: .init(title: L10n.Onboarding.Verification.Decription.title,
                                              subtitle: descriptionViewSubtitle,
                                              buttonTitle: L10n.Onboarding.change))
        ///
        otpTextfField.dataSource = self
        let otpViewModel = OTPTextField.ViewModel(slotCount: viewModel.codeCount)
        otpTextfField.configure(with: otpViewModel)
    }
}
//
// MARK: - Private Handlers
private extension VerificationViewController {
    private func subscribeToOTPCode() {
        // assign to viewModel's code
        otpTextfField.viewModel.$code
            .assign(to: \.code, on: viewModel)
            .store(in: &viewModel.cancellableSet)
        // enable and disable button
        otpTextfField.viewModel.$code
            .map { $0.count == self.viewModel.codeCount }
            .assign(to: \.isEnabled, on: continueButton)
            .store(in: &viewModel.cancellableSet)
    }
}
