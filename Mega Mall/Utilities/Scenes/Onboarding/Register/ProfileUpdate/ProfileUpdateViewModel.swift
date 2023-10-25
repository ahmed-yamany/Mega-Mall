import Foundation
import Combine

// MARK: ProfileUpdateViewModel
class ProfileUpdateViewModel {
    let fullNameViewModel: OnboardingTextField.ViewModel
    let passwordViewModel: OnboardingTextField.ViewModel
    let referalCodeViewModel: OnboardingTextField.ViewModel
    let enableButton: AnyPublisher<Bool, Never>
    var cancellableSet: Set<AnyCancellable> = .init()
    init(fullNameViewModel: OnboardingTextField.ViewModel,
         passwordViewModel: OnboardingTextField.ViewModel,
         referalCodeViewModel: OnboardingTextField.ViewModel) {
        self.fullNameViewModel = fullNameViewModel
        self.passwordViewModel = passwordViewModel
        self.referalCodeViewModel = referalCodeViewModel
        enableButton = Publishers
            .CombineLatest(fullNameViewModel.$text, passwordViewModel.$text)
            .map { fullName, password in
                !fullName.isEmpty && password.count > 5
            }
            .eraseToAnyPublisher()
    }
}
// MARK: Private Handlers
//
private extension ProfileUpdateViewModel {}
