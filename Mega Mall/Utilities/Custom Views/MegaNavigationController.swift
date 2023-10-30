//
//  NavigationController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit
import MakeConstraints
import ViewAnimator

class MegaNavigationController: UINavigationController {
    // MARK: - Views
    //
    let notificationView = UIImageView(image: .megaNotification.withRenderingMode(.alwaysOriginal))
    let shopingCartView = UIImageView(image: .megaShopingCart.withRenderingMode(.alwaysOriginal))
    lazy var notificationItem = UIBarButtonItem(customView: notificationView)
    lazy var shopingCartItem = UIBarButtonItem(customView: shopingCartView)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        //
        configureViews()
        //
        subscribeToNotificaitons()
        subscribeToShopingCart()
    }
    //
    public func addNotificationItem() {
        if visibleViewController?.navigationItem.rightBarButtonItems == nil {
            visibleViewController?.navigationItem.rightBarButtonItems = []
        }
        visibleViewController?.navigationItem.rightBarButtonItems?.append(notificationItem)
        let notificationsTapGesture = UITapGestureRecognizer(target: self, action: #selector(notificationViewAction))
        notificationView.addGestureRecognizer(notificationsTapGesture)
    }
    //
    public func addShopingCartItem() {
        if visibleViewController?.navigationItem.rightBarButtonItems == nil {
            visibleViewController?.navigationItem.rightBarButtonItems = []
        }
        visibleViewController?.navigationItem.rightBarButtonItems?.append(shopingCartItem)
        let shopingCartTapGesture = UITapGestureRecognizer(target: self, action: #selector(shopingCartViewAction))
        shopingCartView.addGestureRecognizer(shopingCartTapGesture)
    }
}
// MARK: - Configurations
extension MegaNavigationController {
    private func configureViews() {
        configureNavigationBar()
    }
    //
    private func configureNavigationBar() {
        configureNavigationBarShadow()
        configureNavigationBarBackButton()
    }
    //
    private func configureNavigationBarShadow() {
        navigationBar.layer.shadowColor = UIColor.megaSecondaryDarkGray.cgColor
        let shadowSize: CGFloat = 0.5
        let contactRect = CGRect(x: -shadowSize, y: navigationBar.frame.height - (shadowSize * 0.4),
                                 width: view.frame.width + shadowSize * 2, height: shadowSize)
        navigationBar.layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        navigationBar.layer.shadowOpacity = 0.4
        navigationBar.layer.shadowRadius = 1
    }
    //
    private func configureNavigationBarBackButton() {
        navigationBar.tintColor = .megaPrimaryNavyBlack
        navigationBar.backIndicatorImage = .megaBack
        navigationBar.backIndicatorTransitionMaskImage = .megaBack
    }
    private func subscribeToNotificaitons() {
        TabBarViewModel.shared.$notifications
            .map { $0.hasUnreadNotification() }
            .map { hasUnreadNotification -> UIImage in
                hasUnreadNotification ? .megaNotificationUnRead : .megaNotification
            }
            .assign(to: \.image, on: notificationView)
           .store(in: &TabBarViewModel.shared.cancellableSet)
    }
    private func subscribeToShopingCart() {
        TabBarViewModel.shared.$cart
            .map { !$0.isEmpty }
            .map { notEmpty -> UIImage in
                notEmpty ? .megaShoppingCartNotEmpty : .megaShopingCart
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
    //
    @objc private func shopingCartViewAction(_ sender: UITapGestureRecognizer) {
        sender.view?.animate(animations: [AnimationType.rotate(angle: -30)])
    }
}
