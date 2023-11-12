//
//  Localizable.swift
//  Doctor-Appointment
//
//  Created by Ahmed Yamany on 11/11/2023.
//

import UIKit

protocol Localizable {
    var localized: String { get }
}

extension UILabel: Localizable {
    @IBInspectable
    var localized: String {
        get {
            text ?? ""
        } set {
            text = NSLocalizedString(newValue, comment: newValue)
        }
    }
}

extension UIButton: Localizable {
    @IBInspectable
    var localized: String {
        get {
            titleLabel?.text ?? ""
        } set {
            let string = NSLocalizedString(newValue, comment: newValue)
            setTitle(string, for: .normal)
        }
    }
}

extension UITextField: Localizable {
    var localized: String {
        get {
            placeholder ?? ""
        } set {
            placeholder = NSLocalizedString(newValue, comment: newValue)
        }
    }
}
