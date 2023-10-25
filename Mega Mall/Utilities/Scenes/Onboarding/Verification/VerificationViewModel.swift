import Foundation
import Combine

// MARK: VerificationViewModel
//
class VerificationViewModel {
    @Published var code: String = ""
    let codeCount: Int = 4
    var cancellableSet: Set<AnyCancellable> = .init()
    let email: String
    let verificationType: VerificationType
    init(email: String, type: VerificationType) {
        self.email = email
        self.verificationType = type
    }
}
// MARK: Private Handlers
//
private extension VerificationViewModel {
}
//
extension VerificationViewModel {
    enum VerificationType {
        case register
        case forgotPassword
    }
}
