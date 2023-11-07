//
//  NavigationController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit
import MakeConstraints
import ViewAnimator
import Extensions

class MegaNavigationController: UINavigationController {
    // MARK: - Views
    //
    let notificationView = UIImageView(image: .megaNotification.withRenderingMode(.alwaysOriginal))
    let shopingCartView = UIImageView(image: .megaShopingCart.withRenderingMode(.alwaysOriginal))
    //
    lazy var notificationItem = UIBarButtonItem(customView: notificationView)
    lazy var shopingCartItem = UIBarButtonItem(customView: shopingCartView)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureViews()
        subscribeToNotificaitons()
        subscribeToShopingCart()
    }
    //
    public func addNotificationItem() {
        initializerightBarButtonItems()
        visibleViewController?.navigationItem.rightBarButtonItems?.append(notificationItem)
        let notificationsTapGesture = UITapGestureRecognizer(target: self, action: #selector(notificationViewAction))
        notificationView.addGestureRecognizer(notificationsTapGesture)
    }
    //
    public func addShopingCartItem() {
        initializerightBarButtonItems()
        visibleViewController?.navigationItem.rightBarButtonItems?.append(shopingCartItem)
        let shopingCartTapGesture = UITapGestureRecognizer(target: self, action: #selector(shopingCartViewAction))
        shopingCartView.addGestureRecognizer(shopingCartTapGesture)
    }
    //
    private func initializerightBarButtonItems() {
        guard let visibleViewController else {
            Logger.log("Failed to wrap visibleViewController", category: \.default, level: .fault)
            return
        }
        if visibleViewController.navigationItem.rightBarButtonItems == nil {
            visibleViewController.navigationItem.rightBarButtonItems = []
        }
    }
}
// MARK: - Configurations
extension MegaNavigationController {
    private func configureViews() {
        configureNavigationBar()
    }
    ///
    private func configureNavigationBar() {
        configureNavigationBarShadow()
        configureNavigationBarBackButton()
    }
    ///
    private func configureNavigationBarShadow() {
        navigationBar.layer.shadowColor = UIColor.megaSecondaryDarkGray.cgColor
        let shadowSize: CGFloat = 0.5
        let contactRect = CGRect(x: -shadowSize, y: navigationBar.frame.height - (shadowSize * 0.4),
                                 width: view.frame.width + shadowSize * 2, height: shadowSize)
        navigationBar.layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        navigationBar.layer.shadowOpacity = 0.4
        navigationBar.layer.shadowRadius = 1
    }
    ///
    private func configureNavigationBarBackButton() {
        navigationBar.tintColor = .megaPrimaryNavyBlack
        navigationBar.backIndicatorImage = .megaBack
        navigationBar.backIndicatorTransitionMaskImage = .megaBack
    }
}
// MARK: - Private Handlers
private extension MegaNavigationController {
    private func subscribeToNotificaitons() {
        TabBarViewModel.shared.$notifications
            .map { notifications -> UIImage in
                notifications.hasUnreadNotification() ? .megaNotificationUnRead : .megaNotification
            }
            .assign(to: \.image, on: notificationView)
            .store(in: &TabBarViewModel.shared.cancellableSet)
    }
    //
    private func subscribeToShopingCart() {
        TabBarViewModel.shared.$cart
            .map { cart -> Bool in
                cart.isEmpty
            }
            .map { isEmpty -> UIImage in
                if !isEmpty {
                    // animate shoping cart when not empty
                    self.shopingCartView.animate(animations: [AnimationType.from(direction: .right, offset: 10)])
                }
                return isEmpty ? .megaShopingCart : .megaShoppingCartNotEmpty
            }
            .assign(to: \.image, on: shopingCartView)
            .store(in: &TabBarViewModel.shared.cancellableSet)
    }
}
// MARK: - UINavigationControllerDelegate
extension MegaNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        viewController.navigationItem.backButtonTitle = ""
    }
}

// MARK: - Actions
extension MegaNavigationController {
    @objc private func notificationViewAction(_ sender: UITapGestureRecognizer) {
        sender.view?.animate(animations: [AnimationType.rotate(angle: -30)])
    }
    ///
    @objc private func shopingCartViewAction(_ sender: UITapGestureRecognizer) {
        sender.view?.animate(animations: [AnimationType.rotate(angle: -30)])
    }
}
