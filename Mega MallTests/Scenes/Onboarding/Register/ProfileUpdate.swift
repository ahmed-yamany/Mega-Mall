//
//  ProfileUpdate.swift
//  Mega MallTests
//
//  Created by Ahmed Yamany on 25/10/2023.
//

import XCTest
@testable import Mega_Mall
// swiftlint:disable all
final class ProfileUpdate: XCTestCase {
    var viewController: ProfileUpdateViewController!
    override func setUpWithError() throws {
        viewController = ProfileUpdateViewController()
        viewController.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        viewController = nil
    }
    func test_outletsConnected() {
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.descriptionView)
        XCTAssertNotNil(viewController.fullNameTextFieldView)
        XCTAssertNotNil(viewController.passwordTextFieldView)
        XCTAssertNotNil(viewController.referalCodeTextFieldView)
        XCTAssertNotNil(viewController.confirmationButton)
        XCTAssertNotNil(viewController.fullNameTextFieldView.label)
        XCTAssertNotNil(viewController.fullNameTextFieldView.textfield)
        XCTAssertNotNil(viewController.passwordTextFieldView.label)
        XCTAssertNotNil(viewController.passwordTextFieldView.textfield)
        XCTAssertNotNil(viewController.referalCodeTextFieldView.label)
        XCTAssertNotNil(viewController.referalCodeTextFieldView.textfield)
    }
    func test_TextFieldViews_whenEditingChanged() {
        // Given
        viewController?.fullNameTextFieldView.textfield.text = "ahmed"
        viewController?.passwordTextFieldView.textfield.text = "ahmed"
        viewController?.referalCodeTextFieldView.textfield.text = "ahmed"
        // When
        viewController?.fullNameTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController?.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController?.referalCodeTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        XCTAssertNotNil(viewController?.fullNameTextFieldView.viewModel?.text)
        XCTAssertNotNil(viewController?.passwordTextFieldView.viewModel?.text)
        XCTAssertNotNil(viewController?.referalCodeTextFieldView.viewModel?.text)
        if let isEmpty = viewController.fullNameTextFieldView.viewModel?.text.isEmpty {
            XCTAssertFalse(isEmpty)
        }
        if let isEmpty = viewController.passwordTextFieldView.viewModel?.text.isEmpty {
            XCTAssertFalse(isEmpty)
        }
        if let isEmpty = viewController.referalCodeTextFieldView.viewModel?.text.isEmpty {
            XCTAssertFalse(isEmpty)
        }
        XCTAssertEqual(viewController?.fullNameTextFieldView.viewModel?.text, "ahmed")
        XCTAssertEqual(viewController?.passwordTextFieldView.viewModel?.text, "ahmed")
        XCTAssertEqual(viewController?.referalCodeTextFieldView.viewModel?.text, "ahmed")
    }
    func test_TextFieldViews_whenConfigure() {
        XCTAssertEqual(viewController?.fullNameTextFieldView.label.text, L10n.Onboarding.UpdateProfile.FullName.label)
        XCTAssertEqual(viewController?.fullNameTextFieldView.textfield.placeholder, L10n.Onboarding.UpdateProfile.FullName.placeholder)
        XCTAssertEqual(viewController?.passwordTextFieldView.label.text, L10n.Onboarding.UpdateProfile.Password.label)
        XCTAssertEqual(viewController?.passwordTextFieldView.textfield.placeholder, L10n.Onboarding.UpdateProfile.Password.placeholder)
        XCTAssertEqual(viewController?.referalCodeTextFieldView.label.text, L10n.Onboarding.UpdateProfile.ReferalCode.label)
        XCTAssertEqual(viewController?.referalCodeTextFieldView.textfield.placeholder, L10n.Onboarding.UpdateProfile.ReferalCode.placeholder)
        XCTAssertEqual(viewController?.confirmationButton.titleLabel?.text, L10n.Onboarding.confirmation)
    }
    func test_Button_isEnabled_whenValid() {
        // given
        viewController.fullNameTextFieldView.textfield.text = "ahmed"
        viewController.passwordTextFieldView.textfield.text = "1234567"
        // When
        viewController.fullNameTextFieldView.textfield.sendActions(for: .editingChanged)
        viewController.passwordTextFieldView.textfield.sendActions(for: .editingChanged)
        // Then
        XCTAssertTrue(viewController.confirmationButton.isEnabled)
    }
}
// swiftlint:enable all
