//
//  OTPView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 23/10/2023.
//

import UIKit
import MakeConstraints
import Combine

// MARK: - ViewModel
//
@available(iOS 14.0, *)
public extension OTPTextField {
    class ViewModel {
        public var slotCount: Int
        public var defaultCharacter: String
        ///
        @Published public var code: String = ""
        @Published public var isCodeValid: Bool = false
        ///
        public init(slotCount: Int = 4, defaultCharacter: String = "_") {
            self.slotCount = slotCount
            self.defaultCharacter = defaultCharacter
        }
    }
}
/// A protocol that provides methods for creating digit labels for OTPTextField.
public protocol OTPTextFieldDataSource: NSObjectProtocol {
    /// Create a digit label for OTPTextField.
    func createDigitLabel() -> UILabel
}

/// A custom UITextField subclass for entering OTP (One-Time Password) codes.
@available(iOS 14.0, *)
open class OTPTextField: UITextField {
    // MARK: - Views
    //
    private var digitsLabels: [UILabel] = []
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    //
    // MARK: - Properties
    open var viewModel: ViewModel!
    open weak var dataSource: OTPTextFieldDataSource?
    // MARK: - Configurations
    private var isConfigured = false
    ///
    /// Configures the OTPTextField with the specified number of slots.
    ///
    /// - Parameter slotCount: The number of slots for entering OTP digits.
    public func configure(with viewModel: ViewModel) {
        guard !isConfigured else { return }
        self.viewModel = viewModel
        isConfigured.toggle()
        configureUI()
        createDigitLabels(viewModel.slotCount)
        addGestureRecognizer(tapRecognizer)
    }
    // MARK: - Private Handlers
    // Configuration code for text field appearance and behavior.
    private func configureUI() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    //
    private func createDigitLabels(_ count: Int) {
        // Create a horizontal stack view for digit labels
        let labelsStackView = createHorizontalStackView()
        //
        // Create and add digit labels to the stack view
        for _ in 1 ... count {
            let label = createDigitLabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            labelsStackView.addArrangedSubview(label)
            digitsLabels.append(label)
        }
        //
        // Add the stack view to the OTPTextField and apply constraints
        addSubview(labelsStackView)
        applyStackViewConstraints(labelsStackView)
    }
    //
    private func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }
    //
    private func applyStackViewConstraints(_ stackView: UIStackView) {
        // Add constraints to make the stack view fill the OTPTextField
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    //
    // Create a digit label using the appropriate source (dataSource or default).
    private func createDigitLabel() -> UILabel {
        if let dataSource = dataSource {
            return dataSource.createDigitLabel()
        } else {
            debugPrint("")
            Logger.log("Couldn't wrap dataSource, We are using the default Style", category: \.default, level: .error)
            return createDefaultDigitLabel()
        }
    }
    //
    private func createDefaultDigitLabel() -> UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "*"
        label.backgroundColor = .gray
        label.layer.cornerRadius = 8
        return label
    }
}
// MARK: - UITextFieldDelegate
@available(iOS 14.0, *)
extension OTPTextField: UITextFieldDelegate {
    // Handling character input in the text field.
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let charachterCount = textField.text?.count else { return false }
        return charachterCount < digitsLabels.count || string == ""
    }
    //
    // Handling text changes in the text field.
    @objc private func textDidChange() {
        guard let text = text, text.count <= digitsLabels.count else {
            Logger.log("text or text count failed", category: \.default, level: .error)
            return
        }
        updateDigitLabels(for: text)
        viewModel.code = text
    }
}
// MARK: - Private Handlers
//
@available(iOS 14.0, *)
private extension OTPTextField {
    // Updating the digit labels based on the entered OTP code.
    func updateDigitLabels(for text: String) {
        for index in 0 ..< digitsLabels.count {
            updateDigitLabel(at: index, for: text)
        }
    }
    //
    // Updating a single digit label based on the entered OTP code.
    func updateDigitLabel(at index: Int, for text: String) {
        let currentLabel = digitsLabels[index]
        if index < text.count {
            let index = text.index(text.startIndex, offsetBy: index)
            currentLabel.text = String(text[index])
        } else {
            currentLabel.text = viewModel.defaultCharacter
        }
    }
}
