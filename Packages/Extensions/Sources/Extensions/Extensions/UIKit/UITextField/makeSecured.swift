//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 21/10/2023.
//

import UIKit
import MakeConstraints

/// An extension to enhance the functionality of UITextField for making it secure with a toggle button.
extension UITextField {
    /// Makes the text input of the UITextField secure with a toggle button for showing/hiding the text.
    public func makeSecured(withTintColor tintColot: UIColor) {
        // Create a UIButton to act as the toggle button for secure text entry.
        let button = UIButton()
        button.widthConstraints(36)
        button.tintColor = tintColot
        button.addTarget(self, action: #selector(securedButtonAction(_:)), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
        // Initialize the secure text entry state and set the initial button image.
        securedButtonAction(button)
    }
    /// Action method invoked when the secure text entry toggle button is tapped.
    /// - Parameter sender: The UIButton that triggered the action.
    @objc private func securedButtonAction(_ sender: UIButton) {
        // Toggle the secure text entry mode of the UITextField.
        isSecureTextEntry.toggle()
        // Update the button image based on the current secure text entry state.
        if isSecureTextEntry {
            if #available(iOS 13.0, *) {
                sender.setImage(UIImage(systemName: "eye"), for: .normal)
            } else {
                fatalError("unresolved UIImage SystemName at less than 13.0 ios Version")
            }
        } else {
            if #available(iOS 13.0, *) {
                sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            } else {
                fatalError("unresolved UIImage SystemName at less than 13.0 ios Version")
            }
        }
    }
}
