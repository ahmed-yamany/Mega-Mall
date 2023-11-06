import Foundation
import Combine

// MARK: RegisterEmailViewModel
class RegisterViewModel: RegisterViewModelType {
    let emailViewModel: OnboardingTextField.ViewModel
    var enableButton: AnyPublisher<Bool, Never>
    ///
    var cancellableSet: Set<AnyCancellable> = .init()
    ///
    init(emailViewModel: OnboardingTextField.ViewModel) {
        self.emailViewModel = emailViewModel
        ///
        enableButton = emailViewModel.$text
            .map { email in
                email.isValidEmail() || email.isValidEgyptPhoneNumber()
            }.eraseToAnyPublisher()
    }
}
// MARK: Private Handlers
//
private extension RegisterViewModel {}
