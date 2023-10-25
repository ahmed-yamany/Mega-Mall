//
//  Verification.swift
//  Mega MallTests
//
//  Created by Ahmed Yamany on 24/10/2023.
//

import XCTest
@testable import Mega_Mall
// swiftlint: disable all
final class Verification: XCTestCase {
    var viewController: VerificationViewController!
    var viewModel: VerificationViewModel!
    override func setUpWithError() throws {
        viewModel = .init(email: "ahmed@gmail.com", type: .register)
        viewController = VerificationViewController(viewModel: viewModel)
        viewController.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        viewController = nil
    }
    func test_outletsConnected() {
        XCTAssertNotNil(viewController.descriptionView)
        XCTAssertNotNil(viewController.otpTextfField)
        XCTAssertNotNil(viewController.continueButton)
    }
    func test_TextFieldViews_whenConfigure() {
        XCTAssertEqual(viewController?.descriptionView.titleLabel.text, L10n.Onboarding.Verification.Decription.title)
        let descriptionViewSubtitle = "\(L10n.Onboarding.Verification.Decription.subtitle) \(viewModel.email)"
        XCTAssertEqual(viewController?.descriptionView.subtitleLabel.text, descriptionViewSubtitle)
    }

    func test_OTPTextView_whenEditingChanged() {
        // Given
        viewController.otpTextfField.text = "0938"
        // When
        viewController.otpTextfField.sendActions(for: .editingChanged)
        // Then
        if let isEmpty = viewController.otpTextfField?.text?.isEmpty {
            XCTAssertFalse(isEmpty)
        }
        XCTAssertEqual(viewController.otpTextfField.text, "0938")
        XCTAssertEqual(viewController.viewModel.code, "0938")
        XCTAssertEqual(viewController.viewModel.code.count, viewModel.codeCount)
    }
    func test_button_isEnabled_whenValidOTP() {
        // given
        viewController?.otpTextfField.text = "7283"
        // When
        viewController?.otpTextfField.sendActions(for: .editingChanged)
        // Then
        if let isEnabled = viewController?.continueButton.isEnabled {
            XCTAssertTrue(isEnabled)
        }
    }
    func test_button_isEnabled_whenInValidOTP() {
        // given
        viewController.otpTextfField.text = ""
        // When
        viewController.otpTextfField.sendActions(for: .editingChanged)
        // Then
        if let isEnabled = viewController?.continueButton.isEnabled {
            XCTAssertFalse(isEnabled)
        }
    }

}
// swiftlint: enable all
