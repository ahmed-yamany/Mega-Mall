//
//  TabBarController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 25/10/2023.
//

import UIKit
import Extensions
import Factory
import ViewAnimator
import MakeConstraints

class TabBarController: AnimatableTabBarController {
    // MARK: - View Controllers
    //
    let homeVC = UINavigationController(rootViewController: LoginViewController())
    let wishlistVC = WishListViewController()
    let orderVC = OrderViewController()
    let accountVC = AccountViewController()
    // MARK: - Properties
    //
    let viewModel = TabBarViewModel.shared
    // MARK: - Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configurations = viewModel.animationConfigurations
        subscribeSelectedItem()
        subscribeIsLogin()
    }

    override func animate(_ view: UIView, at item: UITabBarItem) {
        switch item.tag {
        case TabBarItems.wishlist.rawValue:
            view.animate(animations: [AnimationType.zoom(scale: 1.4)])
        case TabBarItems.order.rawValue:
            view.animate(animations: [AnimationType.rotate(angle: -30)])
        case TabBarItems.account.rawValue:
            view.animate(animations: [AnimationType.zoom(scale: 0.7)])
        case TabBarItems.home.rawValue:
            view.animate(animations: [AnimationType.vector(.init(dx: 1.4, dy: 1.4))])
        default:
            view.layerBorderWidth = 0
            view.layerBorderColor = .clear
        }
    }
}
// MARK: - Configurations
//
extension TabBarController {
    private func configureViews() {
        view.backgroundColor = .megaPrimaryPureWhite
        configureTabBar()
        setupViewControllers()
    }
    private func configureTabBar() {
        tabBar.tintColor = .megaPrimaryBlueOcean
        tabBar.unselectedItemTintColor = .megaPrimaryNavyBlack
        tabBar.layer.shadowColor = UIColor.megaSecondaryHalfGray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: -4, height: -2)
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowRadius = 5
        tabBar.backgroundColor = .megaPrimaryPureWhite
    }
    private func setupViewControllers() {
        homeVC.tabBarItem = UITabBarItem(title: "HOME", image: .tabbarHome.withRenderingMode(.alwaysOriginal),
                                         selectedImage: .tabbarHomeSelected.withRenderingMode(.alwaysOriginal))
        homeVC.tabBarItem.tag = TabBarItems.home.rawValue
        wishlistVC.tabBarItem = UITabBarItem(title: "WISHLIST", image: .tabbarWishlist.withRenderingMode(.alwaysOriginal),
                                             selectedImage: .tabbarWishlistSelected.withRenderingMode(.alwaysOriginal))
        wishlistVC.tabBarItem.tag = TabBarItems.wishlist.rawValue
        orderVC.tabBarItem = UITabBarItem(title: "ORDER", image: .tabbarOrder.withRenderingMode(.alwaysOriginal),
                                          selectedImage: .tabbarOrderSelected.withRenderingMode(.alwaysOriginal))
        orderVC.tabBarItem.badgeValue = ""
        orderVC.tabBarItem.tag = TabBarItems.order.rawValue
        viewControllers = [homeVC, wishlistVC, orderVC, accountVC]
    }
}
// MARK: - Private Handlers
//
extension TabBarController {
    private func subscribeSelectedItem() {
        viewModel.$selectedItem
            .map { $0.rawValue}
            .assign(to: \.selectedIndex, on: self)
            .store(in: &viewModel.cancellableSet)
    }
    private func subscribeIsLogin() {
        viewModel.$isLogin
            .map { isLogin -> (Bool, UITabBarItem) in
                let title: String = isLogin ? "Account": "Login"
                let image: UIImage? = isLogin ? .yamany
                    .resize(to: CGSize(width: 24, height: 24))?
                    .withRenderingMode(.alwaysOriginal) : .tabbarProfile
                let item = UITabBarItem(title: title, image: image, tag: TabBarItems.account.rawValue)
                return (isLogin, item)
            }
            .sink { [unowned self] isLogin, item in
                self.accountVC.tabBarItem = item
                guard isLogin, let imageView = tabBar.subviews.last?.subviews.first as? UIImageView  else {
                    Logger.log("failed to get last tabBarItem's ImageView", category: \.default, level: .info)
                    return
                }
                imageView.layerCornerRadius = 25/2
                imageView.layerBorderWidth = 1
                imageView.layerBorderColor = .megaPrimaryBlueOcean
                imageView.animate(animations: [AnimationType.zoom(scale: 0.5)])
            }
            .store(in: &viewModel.cancellableSet)
    }
}
