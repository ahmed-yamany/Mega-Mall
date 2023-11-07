//
//  TabBarController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 25/10/2023.
//

import UIKit
import Extensions
import ViewAnimator
import MakeConstraints

class TabBarViewController: UITabBarSelectionController {
    // MARK: - View Controllers
    //
    let homeVC = Coordinator.shared.home()
    let wishlistVC = Coordinator.shared.wishlist()
    let orderVC = Coordinator.shared.order()
    let accountVC = Coordinator.shared.account()
    // MARK: - Properties
    //
    let viewModel: TabBarViewModel
    // stores the last selected item to back to whenever wanted
    private(set) var lastItem: UITabBarItem!
    //
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    // MARK: - Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
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
    //
    override func tabBarDidSelect(_ tabBar: UITabBar, item: UITabBarItem, imageView: UIImageView) {
        animateTabBarSelection(item, imageView: imageView)
    }
    //

}
// MARK: - Configurations
//
private extension TabBarViewController {
    func configureViews() {
        view.backgroundColor = .megaPrimaryPureWhite
        configureTabBar()
        setupViewControllers()
    }
    //
    func configureTabBar() {
        tabBar.tintColor = .megaPrimaryBlueOcean
        tabBar.unselectedItemTintColor = .megaPrimaryNavyBlack
        tabBar.layer.shadowColor = UIColor.megaSecondaryHalfGray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: -4, height: -2)
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowRadius = 5
        tabBar.backgroundColor = .megaPrimaryPureWhite
    }
    //
    func setupViewControllers() {
        setupHomeVC()
        setupWhlistVC()
        setupOrderVC()
        viewControllers = [homeVC, wishlistVC, orderVC, accountVC]
    }
    //
    func setupHomeVC() {
        homeVC.tabBarItem = createTabBarItem(title: "HOME",
                                             image: .tabbarHome,
                                             selectedImage: .tabbarHomeSelected,
                                             tag: TabBarItems.home.rawValue)
    }
    //
    func setupWhlistVC() {
        wishlistVC.tabBarItem = createTabBarItem(title: "WISHLIST",
                                                 image: .tabbarWishlist,
                                                 selectedImage: .tabbarWishlistSelected,
                                                 tag: TabBarItems.wishlist.rawValue)
    }
    //
    func setupOrderVC() {
        orderVC.tabBarItem = createTabBarItem(title: "ORDER",
                                              image: .tabbarOrder,
                                              selectedImage: .tabbarOrderSelected,
                                              tag: TabBarItems.order.rawValue)
        setupOrderBadge()
    }
    //
    func setupOrderBadge() {
        viewModel.$orders.sink { orders in
            self.orderVC.tabBarItem.badgeValue = !orders.isEmpty ? "" : nil
        }.store(in: &viewModel.cancellableSet)
    }
    //
    func createTabBarItem(title: String, image: UIImage, selectedImage: UIImage, tag: Int) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title,
                                      image: image.withRenderingMode(.alwaysOriginal),
                                      selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
        tabBarItem.tag = tag
        return tabBarItem
    }
    //
    func handelWhenUserTappedAccount(_ item: UITabBarItem) {
        if item.tag == TabBarItems.account.rawValue {
            LoginManager.shared.checkLogin(notLoginHandeler: {
                self.selectedIndex = self.lastItem?.tag ?? 0
            })
        } else {
            lastItem = item
        }
    }
    //
    func animateTabBarSelection(_ item: UITabBarItem, imageView: UIImageView) {
        switch item.tag {
        case TabBarItems.wishlist.rawValue:
            imageView.animate(animations: [AnimationType.zoom(scale: 1.4)])
        case TabBarItems.order.rawValue:
            imageView.animate(animations: [AnimationType.rotate(angle: -30)])
        case TabBarItems.account.rawValue:
            imageView.animate(animations: [AnimationType.zoom(scale: 0.7)])
        case TabBarItems.home.rawValue:
            imageView.animate(animations: [AnimationType.vector(.init(dx: 1.4, dy: 1.4))])
        default: break
        }
    }
}
private extension TabBarViewController {

}
// MARK: - Private Handlers
//
private extension TabBarViewController {
    /// Subscribes to isLogin and updates the the accountVC's UITabBarItem
    func subscribeIsLogin() {
        viewModel.$isLogin
        /// maps and return the UITabBarItem for the islogin Status
            .map { isLogin -> (Bool, UITabBarItem) in
                let title: String = isLogin ? "Account": "Login"
                ///
                let image: UIImage? = isLogin ? .yamany
                    .resize(to: CGSize(width: 24, height: 24))?
                    .withRenderingMode(.alwaysOriginal) : .tabbarProfile
                ///
                let item = UITabBarItem(title: title, image: image, tag: TabBarItems.account.rawValue)
                return (isLogin, item)
            }
            .sink { [unowned self] isLogin, item in
                updateAccountTabBarItem(item, isLogin: isLogin)
            }
            .store(in: &viewModel.cancellableSet)
    }
    //
    func updateAccountTabBarItem(_ item: UITabBarItem, isLogin: Bool) {
        self.accountVC.tabBarItem = item
        guard isLogin else {
            Logger.log("User is not login", category: \.default, level: .info)
            return
        }
        ///
        let accountView = tabBar.subviews.last
        guard let userImageView = accountView?.subviews.first as? UIImageView  else {
            Logger.log("failed to get last tabBarItem's ImageView", category: \.default, level: .info)
            return
        }
        userImageView.layerCornerRadius = 25/2
        userImageView.layerBorderWidth = 1
        userImageView.layerBorderColor = .megaPrimaryBlueOcean
        userImageView.animate(animations: [AnimationType.zoom(scale: 0.5)])
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
            .map { isHidden in
                self.tabBar.animate(animations: [AnimationType.from(direction: .bottom, offset: 100)])
                return isHidden
            }
            .assign(to: \.isHidden, on: tabBar)
            .store(in: &viewModel.cancellableSet)
    }
}
