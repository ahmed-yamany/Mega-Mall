import Foundation
import Combine

// MARK: VerificationViewModel
//
class VerificationViewModel {
    @Published var code: String = ""
    let codeCount: Int = 4
    var cancellableSet: Set<AnyCancellable> = .init()
    let email: String
    init(email: String) {
        self.email = email
    }
}
// MARK: Private Handlers
//
private extension VerificationViewModel {}
