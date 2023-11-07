//
//  Home.swift
//  Mega MallTests
//
//  Created by Ahmed Yamany on 07/11/2023.
//

import XCTest
@testable import Mega_Mall

final class HomeTest: XCTestCase {
    var viewController: HomeViewController!
    var navigationController: MegaNavigationController!
    override func setUpWithError() throws {
        viewController = .init()
        navigationController = .init(rootViewController: viewController)
        navigationController.loadViewIfNeeded()
        viewController.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        viewController = nil
    }
    //
    func test_notNil() {
        XCTAssertNotNil(viewController.navigationController)
        XCTAssertNotNil(viewController.searchTextField)
        XCTAssertNotNil(viewController.collectionView)
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertEqual(navigationController.visibleViewController, viewController)
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
        XCTAssertFalse((viewController.navigationItem.rightBarButtonItems ?? []) .isEmpty )
    }
}
