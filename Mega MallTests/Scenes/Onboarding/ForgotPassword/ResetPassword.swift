//
//  ForgotPassword.swift
//  Mega MallTests
//
//  Created by Ahmed Yamany on 24/10/2023.
//

import XCTest
@testable import Mega_Mall

final class ResetPassword: XCTestCase {
    var viewController: ResetPasswordViewController!
    override func setUpWithError() throws {
        viewController = ResetPasswordViewController()
        viewController.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        viewController = nil
    }
    func test_outletsConnected() {
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.descriptionView)
        XCTAssertNotNil(viewController.emailTextFieldView)
        XCTAssertNotNil(viewController.emailTextFieldView.viewModel)
        XCTAssertNotNil(viewController.resetButton)
        XCTAssertNotNil(viewController.emailTextFieldView.label)
        XCTAssertNotNil(viewController.emailTextFieldView.textfield)
    }
    func test_TextFieldViews_whenEditingChanged() {
        // Given
        viewController.emailTextFieldView.textfield.text = "ahmed"
        // When
        viewController.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        XCTAssertNotNil(viewController.emailTextFieldView.viewModel.text)
        let isEmpty = viewController.emailTextFieldView.viewModel.text.isEmpty
        XCTAssertFalse(isEmpty)
        XCTAssertEqual(viewController.emailTextFieldView.viewModel.text, "ahmed")
    }
    func test_TextFieldViews_whenConfigure() {
        XCTAssertEqual(viewController.emailTextFieldView.label.text, L10n.Onboarding.ForgotPassword.Email.label)
        XCTAssertEqual(viewController.emailTextFieldView.textfield.placeholder, L10n.Onboarding.ForgotPassword.Email.placeholder)
    }
    func test_resetButton_isEnabled_whenValidEmail() {
        // given
        viewController.emailTextFieldView.textfield.text = "ahmed@gmail.com"
        // When
        viewController.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        let isEnabled = viewController.resetButton.isEnabled
        XCTAssertTrue(isEnabled)
    }
    func test_resetButton_isEnabled_whenValidPhoneNumber() {
        // given
        viewController.emailTextFieldView.textfield.text = "01551608020"
        // When
        viewController.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        let isEnabled = viewController.resetButton.isEnabled
        XCTAssertTrue(isEnabled)
    }
    func test_resetButton_isEnabled_whenInValidEmail() {
        // given
        viewController.emailTextFieldView.textfield.text = "ahmed"
        // when
        viewController.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        // then
        let isEnabled = viewController.resetButton.isEnabled
        XCTAssertFalse(isEnabled)
    }
    func test_resetButton_isEnabled_whenInValidPhoneNumber() {
        // given
        viewController.emailTextFieldView.textfield.text = "017262"
        // when
        viewController.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        // then
        let isEnabled = viewController.resetButton.isEnabled
        XCTAssertFalse(isEnabled)
    }
}
