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

class TabBarViewController: AnimatableTabBarController {
    // MARK: - View Controllers
    //
    let homeVC = MegaNavigationController(rootViewController: HomeViewController())
    let wishlistVC = WishListViewController()
    let orderVC = OrderViewController()
    let accountVC = AccountViewController()
    // MARK: - Properties
    //
    let viewModel = TabBarViewModel.shared
    // stores the last selected item to back to whenever wanted
    private var lastItem: UITabBarItem?
    // MARK: - Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configurations = viewModel.animationConfigurations
        subscribeSelectedItem()
        subscribeIsLogin()
        subscribeTabBarIsHidden()
        lastItem = tabBar.selectedItem
    }
    //
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        super.tabBar(tabBar, didSelect: item)
        handelWhenUserTappedAccount(item)
    }
    // animates a specific tab bar item.
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
        default: break
        }
    }
}
// MARK: - Configurations
//
private extension TabBarViewController {
    func configureViews() {
        view.backgroundColor = .megaPrimaryPureWhite
        configureTabBar()
        setupViewControllers()
    }
    ///
    func configureTabBar() {
        tabBar.tintColor = .megaPrimaryBlueOcean
        tabBar.unselectedItemTintColor = .megaPrimaryNavyBlack
        /// tabbar  shadow
        tabBar.layer.shadowColor = UIColor.megaSecondaryHalfGray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: -4, height: -2)
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowRadius = 5
        ///
        tabBar.backgroundColor = .megaPrimaryPureWhite
    }
    ///
    func setupViewControllers() {
        setupHomeVC()
        setupWhlistVC()
        setupOrderVC()
        viewControllers = [homeVC, wishlistVC, orderVC, accountVC]
    }
    ///
    func setupHomeVC() {
        homeVC.tabBarItem = UITabBarItem(title: "HOME",
                                         image: .tabbarHome.withRenderingMode(.alwaysOriginal),
                                         selectedImage: .tabbarHomeSelected.withRenderingMode(.alwaysOriginal))
        homeVC.tabBarItem.tag = TabBarItems.home.rawValue
    }
    ///
    func setupWhlistVC() {
        wishlistVC.tabBarItem = UITabBarItem(title: "WISHLIST",
                                             image: .tabbarWishlist.withRenderingMode(.alwaysOriginal),
                                             selectedImage: .tabbarWishlistSelected.withRenderingMode(.alwaysOriginal))
        wishlistVC.tabBarItem.tag = TabBarItems.wishlist.rawValue
    }
    ///
    func setupOrderVC() {
        orderVC.tabBarItem = UITabBarItem(title: "ORDER",
                                          image: .tabbarOrder.withRenderingMode(.alwaysOriginal),
                                          selectedImage: .tabbarOrderSelected.withRenderingMode(.alwaysOriginal))
        orderVC.tabBarItem.tag = TabBarItems.order.rawValue
        //
        viewModel.$orders
            .sink { orders in
                self.orderVC.tabBarItem.badgeValue = !orders.isEmpty ? "" : nil
            }.store(in: &viewModel.cancellableSet)
    }
}
// MARK: - Private Handlers
//
private extension TabBarViewController {
    /// Subscribes to isLogin and updates the the accountVC's UITabBarItem
    func subscribeIsLogin() {
        viewModel.$isLogin
        /// maps and return the UITabBarItem for the islogin Status
            .map { isLogin -> (Bool, UITabBarItem) in
                let title: String = isLogin ? "Account": L10n.Onboarding.login
                ///
                let image: UIImage? = isLogin ? .yamany
                    .resize(to: CGSize(width: 24, height: 24))?
                    .withRenderingMode(.alwaysOriginal) : .tabbarProfile
                /// the new Item for accountVC
                let item = UITabBarItem(title: title, image: image, tag: TabBarItems.account.rawValue)
                return (isLogin, item)
            }
            .sink { [unowned self] isLogin, item in
                self.accountVC.tabBarItem = item
                guard isLogin, let userImageView = tabBar.subviews.last?.subviews.first as? UIImageView  else {
                    Logger.log("failed to get last tabBarItem's ImageView", category: \.default, level: .info)
                    return
                }
                userImageView.layerCornerRadius = 25/2
                userImageView.layerBorderWidth = 1
                userImageView.layerBorderColor = .megaPrimaryBlueOcean
                userImageView.animate(animations: [AnimationType.zoom(scale: 0.5)])
            }
            .store(in: &viewModel.cancellableSet)
    }
    /// lets the viewModel has the ability to change the selected item
    func subscribeSelectedItem() {
        viewModel.$selectedItem
            .map { $0.rawValue }
            .assign(to: \.selectedIndex, on: self)
            .store(in: &viewModel.cancellableSet)
    }
    ///
    func subscribeTabBarIsHidden() {
        viewModel.$tabBarIsHidden
            .map {
                self.tabBar.animate(animations: [AnimationType.from(direction: .bottom, offset: 100)])
                return $0
            }
            .assign(to: \.isHidden, on: tabBar)
            .store(in: &viewModel.cancellableSet)
    }
    ///
    func handelWhenUserTappedAccount(_ item: UITabBarItem) {
        if item.tag == TabBarItems.account.rawValue {
            LoginManager.shared.checkLogin(notLoginHandeler: {
                self.selectedIndex = self.lastItem?.tag ?? 0
            })
        } else {
            lastItem = item
        }
    }
}
