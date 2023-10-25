import Foundation
import Combine

// MARK: ResetPasswordViewModel
//
class ResetPasswordViewModel {
    let emailViewModel: OnboardingTextField.ViewModel
    var enableButton: AnyPublisher<Bool, Never>
    var cancellableSet: Set<AnyCancellable> = []
    init(emailViewModel: OnboardingTextField.ViewModel) {
        self.emailViewModel = emailViewModel
        enableButton = emailViewModel.$text.map { email in
            email.isValidEmail() || email.isValidEgyptPhoneNumber()
        }.eraseToAnyPublisher()
    }
}
// MARK: Private Handlers
//
private extension ResetPasswordViewModel {}
