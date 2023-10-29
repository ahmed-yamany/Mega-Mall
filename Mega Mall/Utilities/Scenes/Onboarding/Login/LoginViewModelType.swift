import Foundation
import Combine
/// ResetPassword Input & Output
///
typealias LoginViewModelType = LoginViewModelInput & LoginViewModelOutput

/// ResetPassword ViewModel Input
///
protocol LoginViewModelInput {
    var emailViewModel: OnboardingTextField.ViewModel { get }
    var passwordViewModel: OnboardingTextField.ViewModel { get }
}

/// ResetPassword ViewModel Output
///
protocol LoginViewModelOutput {
    var enableButton: AnyPublisher<Bool, Never> { get }
    var cancellableSet: Set<AnyCancellable> { get set }
    func performLogin() -> AnyPublisher<Bool, Never>
}
