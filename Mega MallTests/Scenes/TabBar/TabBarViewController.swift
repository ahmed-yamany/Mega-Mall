//
//  TabBarViewController.swift
//  Mega MallTests
//
//  Created by Ahmed Yamany on 07/11/2023.
//

import XCTest
@testable import Mega_Mall

final class TabBarViewControllerTests: XCTestCase {
    var viewController: TabBarViewController!
    var viewModel: TabBarViewModel!
    override func setUpWithError() throws {
        viewModel = TabBarViewModel.shared
        viewController = .init(viewModel: viewModel)
        viewController.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        viewModel = nil
        viewController = nil
    }
    //
    func test_notNil() {
        XCTAssertNotNil(viewController.homeVC)
        XCTAssertNotNil(viewController.wishlistVC)
        XCTAssertNotNil(viewController.orderVC)
        XCTAssertNotNil(viewController.accountVC)
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.lastItem)
        XCTAssertNotNil(viewController.homeVC.tabBarItem)
        XCTAssertNotNil(viewController.wishlistVC.tabBarItem)
        XCTAssertNotNil(viewController.orderVC.tabBarController)
        XCTAssertNotNil(viewController.accountVC.tabBarItem)
        XCTAssertNotNil(viewController.homeVC.tabBarController)
        XCTAssertNotNil(viewController.wishlistVC.tabBarController)
        XCTAssertNotNil(viewController.orderVC.tabBarController)
        XCTAssertNotNil(viewController.accountVC.tabBarController)
        XCTAssertNotNil(viewController.homeVC.visibleViewController)
        XCTAssertNotNil(viewController.wishlistVC.visibleViewController)
        XCTAssertNotNil(viewController.orderVC.visibleViewController)
        XCTAssertNotNil(viewController.accountVC.visibleViewController)
        XCTAssertNotNil(viewController.viewModel.login)
        ///
        viewModel.orders.removeAll()
        XCTAssertNil(viewController.orderVC.tabBarItem.badgeValue)
        viewModel.orders.append(Order())
        XCTAssertNotNil(viewController.orderVC.tabBarItem.badgeValue)
    }
    //
    func test_selectedItem() {
        viewModel.selectedItem = .order
        XCTAssertEqual(viewModel.selectedItem.rawValue, viewController.selectedIndex)
        viewModel.selectedItem = .wishlist
        XCTAssertEqual(viewModel.selectedItem.rawValue, viewController.selectedIndex)
    }
    //
    func test_tabBar_isHidden() {
        viewModel.tabBarIsHidden = true
        XCTAssertTrue(viewController.tabBar.isHidden)
        //
        viewModel.tabBarIsHidden = false
        XCTAssertFalse(viewController.tabBar.isHidden)
    }
    //
    func test_logout() {
        viewModel.logout()
        XCTAssertFalse(viewModel.isLogin)
        XCTAssertFalse(viewModel.login ?? false)
        XCTAssertTrue(viewModel.cart.isEmpty)
        XCTAssertTrue(viewModel.orders.isEmpty)
        XCTAssertTrue(viewModel.whishies.isEmpty)
        XCTAssertTrue(viewModel.notifications.isEmpty)
    }
}
