import Foundation
import Combine
import Extensions

extension UserDefaultsKeys {
    var login: String { "Login" }
}

// MARK: LoginViewModel
class LoginViewModel: LoginViewModelType {
    let emailViewModel: OnboardingTextField.ViewModel
    let passwordViewModel: OnboardingTextField.ViewModel
    @UserDefault<Bool>(key: \.login) var login
    //
    let enableButton: AnyPublisher<Bool, Never>
    var cancellableSet: Set<AnyCancellable> = .init()
    //
    init(emailViewModel: OnboardingTextField.ViewModel, passwordViewModel: OnboardingTextField.ViewModel ) {
        self.emailViewModel = emailViewModel
        self.passwordViewModel = passwordViewModel
        //
        enableButton = Publishers
            .CombineLatest(emailViewModel.$text, passwordViewModel.$text)
            .map { email, password in
                (email.isValidEmail() || email.isValidEgyptPhoneNumber()) && !password.isEmpty
            }
            .eraseToAnyPublisher()
    }
    //
    func performLogin() -> AnyPublisher<Bool, Never> {
        Publishers
            .Zip(Just(emailViewModel.text), Just(passwordViewModel.text))
            .map { email, password -> Bool in
                let login = email == "01551608020" && password == "123456789"
                self.login = login
                return login
            }
            .eraseToAnyPublisher()
    }
}
