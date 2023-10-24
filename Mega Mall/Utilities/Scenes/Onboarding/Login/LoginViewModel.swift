import Foundation
import Combine
import Extensions

// MARK: LoginViewModel
class LoginViewModel: LoginViewModelType {
    let emailViewModel: OnboardingTextField.ViewModel
    let passwordViewModel: OnboardingTextField.ViewModel
    let enableButton: AnyPublisher<Bool, Never>
    var cancellableSet: Set<AnyCancellable> = .init()
    init(emailViewModel: OnboardingTextField.ViewModel,
         passwordViewModel: OnboardingTextField.ViewModel ) {
        self.emailViewModel = emailViewModel
        self.passwordViewModel = passwordViewModel
        enableButton = Publishers
            .CombineLatest(emailViewModel.$text, passwordViewModel.$text)
            .map { email, password in
                (email.isValidEmail() || email.isValidEgyptPhoneNumber()) && !password.isEmpty
            }.eraseToAnyPublisher()
    }
}
