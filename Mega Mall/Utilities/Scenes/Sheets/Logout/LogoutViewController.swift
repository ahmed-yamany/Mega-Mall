import UIKit

class LogoutViewController: SheetViewController {
    // MARK: Outlets
    let logoutView = LogoutView()
    //
    // MARK: - Properties
    //
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}
//
// MARK: - Actions
extension LogoutViewController {}
//
// MARK: - Configurations
extension LogoutViewController {
    private func configureViews() {
        title = "Logout"
        addChild(logoutView)
    }
}
//
// MARK: - Private Handlers
private extension LogoutViewController {}
