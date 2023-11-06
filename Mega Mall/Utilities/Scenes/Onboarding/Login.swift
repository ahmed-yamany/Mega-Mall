//
//  Login.swift
//  Mega MallTests
//
//  Created by Ahmed Yamany on 24/10/2023.
//

import XCTest
@testable import Mega_Mall

final class Login: XCTestCase {
    var viewController: LoginViewController!
    override func setUpWithError() throws {
        viewController = LoginViewController()
        viewController?.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        viewController = nil
    }
    func test_outletsConnected() {
        XCTAssertNotNil(viewController?.viewModel)
        XCTAssertNotNil(viewController?.descriptionView)
        //
        XCTAssertNotNil(viewController?.emailTextFieldView)
        XCTAssertNotNil(viewController?.emailTextFieldView.viewModel)
        XCTAssertNotNil(viewController?.passwordTextFieldView)
        XCTAssertNotNil(viewController?.passwordTextFieldView.viewModel)
        //
        XCTAssertNotNil(viewController?.signinButton)
        //
        XCTAssertNotNil(viewController?.emailTextFieldView.label)
        XCTAssertNotNil(viewController?.emailTextFieldView.textfield)
        //
        XCTAssertNotNil(viewController?.passwordTextFieldView.label)
        XCTAssertNotNil(viewController?.passwordTextFieldView.textfield)
    }
    func test_TextFieldViews_whenEditingChanged() {
        // Given
        viewController?.emailTextFieldView.textfield.text = "ahmed"
        viewController?.passwordTextFieldView.textfield.text = "ahmed"
        // When
        viewController?.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController?.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        XCTAssertNotNil(viewController?.emailTextFieldView.viewModel?.text)
        XCTAssertNotNil(viewController?.passwordTextFieldView.viewModel?.text)
        //
        if let isEmpty = viewController?.emailTextFieldView.viewModel?.text.isEmpty {
            XCTAssertFalse(isEmpty)
        }
        if let isEmpty = viewController?.passwordTextFieldView.viewModel?.text.isEmpty {
            XCTAssertFalse(isEmpty)
        }
        //
        XCTAssertEqual(viewController?.emailTextFieldView.viewModel?.text, "ahmed")
        XCTAssertEqual(viewController?.passwordTextFieldView.viewModel?.text, "ahmed")
    }
    func test_TextFieldViews_whenConfigure() {
        XCTAssertEqual(viewController?.emailTextFieldView.label.text, L10n.Onboarding.Login.Email.label)
        XCTAssertEqual(viewController?.emailTextFieldView.textfield.placeholder, L10n.Onboarding.Login.Email.placeholder)
        XCTAssertEqual(viewController?.passwordTextFieldView.label.text, L10n.Onboarding.Login.Password.label)
        XCTAssertEqual(viewController?.passwordTextFieldView.textfield.placeholder, L10n.Onboarding.Login.Password.placeholder)
    }
    func test_signinButton_isEnabled_whenValidEmail() {
        // given
        viewController?.emailTextFieldView.textfield.text = "ahmed@gmail.com"
        viewController?.passwordTextFieldView.textfield.text = "ahmed"
        // When
        viewController?.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController?.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        if let isEnabled = viewController?.signinButton.isEnabled {
            XCTAssertTrue(isEnabled)
        }
    }
    func test_signinButton_isEnabled_whenValidPhoneNumber() {
        // given
        viewController?.emailTextFieldView.textfield.text = "01551608020"
        viewController?.passwordTextFieldView.textfield.text = "ahmed"
        // When
        viewController?.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController?.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        if let isEnabled = viewController?.signinButton.isEnabled {
            XCTAssertTrue(isEnabled)
        }
    }
    func test_signinButton_isEnabled_whenInValidEmail() {
        // given
        viewController?.emailTextFieldView.textfield.text = "ahmed"
        viewController?.passwordTextFieldView.textfield.text = "ahmed"
        // when
        viewController?.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController?.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        // then
        if let isEnabled = viewController?.signinButton.isEnabled {
            XCTAssertFalse(isEnabled)
        }
    }
    func test_signinButton_isEnabled_whenInValidPhoneNumber() {
        // given
        viewController?.emailTextFieldView.textfield.text = "017262"
        viewController?.passwordTextFieldView.textfield.text = "ahmed"
        // when
        viewController?.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController?.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        // then
        if let isEnabled = viewController?.signinButton.isEnabled {
            XCTAssertFalse(isEnabled)
        }
    }
    func test_signinButton_isEnabled_whenPasswordEmpty() {
        // given
        viewController?.emailTextFieldView.textfield.text = "ahmed@gmail.com"
        // when
        viewController?.emailTextFieldView.textfield.sendActions(for: .editingChanged)
        // then
        if let isEnabled = viewController?.signinButton.isEnabled {
            XCTAssertFalse(isEnabled)
        }
    }
    func test_signinButton_isEnabled_whenEmailEmpty() {
        // given
        viewController?.passwordTextFieldView.textfield.text = "ahmed"
        // when
        viewController?.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        // then
        if let isEnabled = viewController?.signinButton.isEnabled {
            XCTAssertFalse(isEnabled)
        }
    }
}
