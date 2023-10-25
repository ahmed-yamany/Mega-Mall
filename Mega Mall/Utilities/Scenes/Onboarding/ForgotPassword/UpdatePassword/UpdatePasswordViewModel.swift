import Foundation
import Combine
// MARK: UpdatePasswordViewModel
//
class UpdatePasswordViewModel {
    let passwordViewModel: OnboardingTextField.ViewModel
    let confirmPasswordViewModel: OnboardingTextField.ViewModel
    let enableButton: AnyPublisher<Bool, Never>
    var cancellableSet: Set<AnyCancellable> = .init()
    init(passwordViewModel: OnboardingTextField.ViewModel, confirmPasswordViewModel: OnboardingTextField.ViewModel) {
        self.passwordViewModel = passwordViewModel
        self.confirmPasswordViewModel = confirmPasswordViewModel
        enableButton = Publishers
            .CombineLatest(passwordViewModel.$text, confirmPasswordViewModel.$text)
            .map { password, confirmPassword -> Bool in
                password.count > 5 && confirmPassword == password
            }
            .eraseToAnyPublisher()
    }
}
// MARK: Private Handlers
//
private extension UpdatePasswordViewModel {}
