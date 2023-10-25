//
//  UpdatePassword.swift
//  Mega MallTests
//
//  Created by Ahmed Yamany on 25/10/2023.
//

import XCTest
@testable import Mega_Mall
// swiftlint:disable all
final class UpdatePassword: XCTestCase {
    var viewController: UpdatePasswordViewController!
    override func setUpWithError() throws {
        viewController = UpdatePasswordViewController()
        viewController?.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        viewController = nil
    }
    func test_outletsConnected() {
        XCTAssertNotNil(viewController.descriptionView)
        XCTAssertNotNil(viewController.passwordTextFieldView)
        XCTAssertNotNil(viewController.confirmPasswordTextFieldView)
        XCTAssertNotNil(viewController.updateButton)
        XCTAssertNotNil(viewController.passwordTextFieldView.label)
        XCTAssertNotNil(viewController.passwordTextFieldView.textfield)
        XCTAssertNotNil(viewController.confirmPasswordTextFieldView.label)
        XCTAssertNotNil(viewController.confirmPasswordTextFieldView.textfield)
    }
    func test_TextFieldViews_whenEditingChanged() {
        // Given
        let password = "dfadsfadsfa"
        let confirmPassword = "fadsfasdfads"
        viewController.passwordTextFieldView.textfield.text = password
        viewController.confirmPasswordTextFieldView.textfield.text = confirmPassword
        // When
        viewController.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController.confirmPasswordTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        XCTAssertNotNil(viewController.passwordTextFieldView.viewModel?.text)
        XCTAssertNotNil(viewController.confirmPasswordTextFieldView.viewModel?.text)
        if let isEmpty = viewController.passwordTextFieldView.viewModel?.text.isEmpty {
            XCTAssertFalse(isEmpty)
        }
        if let isEmpty = viewController.confirmPasswordTextFieldView.viewModel?.text.isEmpty {
            XCTAssertFalse(isEmpty)
        }
        XCTAssertEqual(viewController.passwordTextFieldView.viewModel?.text, password)
        XCTAssertEqual(viewController.confirmPasswordTextFieldView.viewModel?.text, confirmPassword)
    }
    func test_TextFieldViews_whenConfigure() {
        XCTAssertEqual(viewController.passwordTextFieldView.label.text, L10n.Onboarding.UpdatePassword.Password.label)
        XCTAssertEqual(viewController.passwordTextFieldView.textfield.placeholder, L10n.Onboarding.UpdatePassword.Password.placeholder)
        XCTAssertEqual(viewController.confirmPasswordTextFieldView.label.text, L10n.Onboarding.UpdatePassword.ConfirmPassword.label)
        XCTAssertEqual(viewController.confirmPasswordTextFieldView.textfield.placeholder, L10n.Onboarding.UpdatePassword.ConfirmPassword.placeholder)
        XCTAssertEqual(viewController.updateButton.titleLabel?.text, L10n.Onboarding.saveUpdates)
    }
    func test_Button_isEnabled_whenValid() {
        // given
        viewController.passwordTextFieldView.textfield.text = "1234567"
        viewController.confirmPasswordTextFieldView.textfield.text = "1234567"
        // When
        viewController.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController.confirmPasswordTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        XCTAssertTrue(viewController.updateButton.isEnabled)
    }
    func test_Button_isEnabled_whenPasswordsNotEqual() {
        // given
        viewController.passwordTextFieldView.textfield.text = "1234567"
        viewController.confirmPasswordTextFieldView.textfield.text = "1234"
        // When
        viewController.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController.confirmPasswordTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        XCTAssertFalse(viewController.updateButton.isEnabled)
    }
}
// swiftlint:enable all
