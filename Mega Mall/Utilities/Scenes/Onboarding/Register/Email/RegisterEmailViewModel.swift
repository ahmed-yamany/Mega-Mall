import Foundation
import Combine

// MARK: RegisterEmailViewModel
//
class RegisterEmailViewModel {
    var emailViewModel: OnboardingTextField.ViewModel = .init(model:
            .init(label: L10n.Onboarding.Register.Email.label,
                  placeholder: L10n.Onboarding.Register.Email.placeholder))
    @Published var isValid: Bool = false
    var cancellableSet: Set<AnyCancellable> = .init()
    init() {
        emailViewModel.$text.sink { [unowned self] email in
            isValid = email.isValidEmail() || email.isValidEgyptPhoneNumber()
        }.store(in: &cancellableSet)
    }
}
// MARK: Private Handlers
//
private extension RegisterEmailViewModel {}
