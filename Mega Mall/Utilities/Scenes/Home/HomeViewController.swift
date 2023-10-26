import UIKit
import ViewAnimator
import Extensions

class HomeViewController: UIViewController {
    // MARK: Outlets
    //
    // MARK: Properties
    private let viewModel: HomeViewModelType
    //
    // MARK: Init
    init() {
        self.viewModel = HomeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}
//
// MARK: - Actions
extension HomeViewController {}
//
// MARK: - Configurations
extension HomeViewController {
    private func configureViews() {
        configureNavigationItem()
    }
    private func configureNavigationItem() {
        navigationItem.addTitleLabel(with: "Mega Mall", color: .megaPrimaryBlueOcean, font: .h2)
        let notificationView = UIImageView(image: .megaNotification.withRenderingMode(.alwaysOriginal))
        let notificationItem = UIBarButtonItem(customView: notificationView)
        let shopingCartView = UIImageView(image: .megaShopingCart.withRenderingMode(.alwaysOriginal))
        let shopingCartItem = UIBarButtonItem(customView: shopingCartView)
        navigationItem.rightBarButtonItems = [shopingCartItem, notificationItem]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(notificationViewAction))
        notificationView.addGestureRecognizer(tapGesture)
        let shopingCarttapGesture = UITapGestureRecognizer(target: self, action: #selector(notificationViewAction))
        shopingCartView.addGestureRecognizer(shopingCarttapGesture)
    }
    @objc private func notificationViewAction(_ sender: UITapGestureRecognizer) {
        sender.view?.animate(animations: [AnimationType.rotate(angle: -30)])
    }
}
//
// MARK: - Private Handlers
private extension HomeViewController {}
