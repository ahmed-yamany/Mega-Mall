import Foundation
import Combine
import Extensions
import SwiftUI
// MARK: LoginViewModel
//
class LoginViewModel {
    var emailViewModel: OnboardingTextField.ViewModel = .init(model: .init(label: L10n.Onboarding.Login.Email.label,
                                                                           placeholder: L10n.Onboarding.Login.Email.placeholder))
    var passwordViewModel: OnboardingTextField.ViewModel = .init(model:
            .init(label: L10n.Onboarding.Login.Password.label,
                  placeholder: L10n.Onboarding.Login.Password.placeholder,
                  securedTextField: true))
    @Published var isValid: Bool = false
    var cancellableSet: Set<AnyCancellable> = .init()
    init() {
        subscribeToPublishers()
    }
}

// MARK: Private Handlers
//
extension LoginViewModel {
    private func subscribeToPublishers() {
        Publishers
            .CombineLatest(emailViewModel.$text, passwordViewModel.$text)
            .sink { [unowned self]  email, password in
                if (email.isValidEmail() || email.isValidEgyptPhoneNumber()) && !password.isEmpty {
                    isValid = true
                } else {
                    isValid = false
                }
            }.store(in: &cancellableSet)
    }
}
