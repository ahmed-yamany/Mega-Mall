//
//  OTPView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 23/10/2023.
//

import UIKit
import MakeConstraints
import Combine

/// A custom UITextField subclass for entering OTP (One-Time Password) codes.
class OTPTextField: UITextField {
    // MARK: - View
    //
    private var digitsLabels: [UILabel] = []
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    // MARK: - Properties
    let viewModel: ViewModel = .init()
    private var isConfigured = false
}
// MARK: - Configurations
//
extension OTPTextField {
    /// Configures the OTPTextField with the specified number of slots.
    /// - Parameter slotCount: The number of slots for entering OTP digits.
    public func configure(with slotCount: Int = 4) {
        guard isConfigured == false else { return }
        isConfigured.toggle()
        configureTextField()
        let labelsStackView = createLabelStackView(with: slotCount)
        addSubview(labelsStackView)
        addGestureRecognizer(tapRecognizer)
        labelsStackView.fillSuperview()
    }
    private func createLabelStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        (1 ... count).forEach { _ in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = .h3
            label.text = viewModel.defaultCharacter
            label.backgroundColor = .megaSecondarySoftGray
            label.layerCornerRadius = 8
            stackView.addArrangedSubview(label)
            digitsLabels.append(label)
        }
        return stackView
    }
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
}
// MARK: - ViewModel
//
extension OTPTextField {
    /// The ViewModel structure for DescriptionView. It represents the data required to display information in the user interface.
    class ViewModel {
        @Published var code: String = ""
        @Published var isCodeValid: Bool = false
        var defaultCharacter = "_"
    }
}
// MARK: - UITextFieldDelegate
//
extension OTPTextField: UITextFieldDelegate {
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let charachterCount = textField.text?.count else { return false }
        return charachterCount < digitsLabels.count || string == ""
    }
    @objc private func textDidChange() {
        guard let text = text, text.count <= digitsLabels.count else {
            Logger.log("text or text count failed", category: \.default, level: .error)
            return
        }
        updateDigitLabels(for: text)
        viewModel.code = text
    }
}
// MARK: Private Handlers
//
private extension OTPTextField {
    private func updateDigitLabels(for text: String) {
        for index in 0 ..< digitsLabels.count {
            updateDigitLabel(at: index, for: text)
        }
    }
    private func updateDigitLabel(at index: Int, for text: String) {
        let currentLabel = digitsLabels[index]
        if index < text.count {
            let index = text.index(text.startIndex, offsetBy: index)
            currentLabel.text = String(text[index])
        } else {
            currentLabel.text = viewModel.defaultCharacter
        }
    }
}
