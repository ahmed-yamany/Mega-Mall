//
//  Validator.swift
//
//  Created by Ahmed Yamany on 21/10/2023.
//

import Foundation
/// An extension that adds validation methods to the `String` type.
extension String {
    /// Validate a string against a specified pattern using regular expressions.
    ///
    /// - Parameters:
    ///   - pattern: The regular expression pattern to match against.
    /// - Returns: `true` if the string matches the pattern; otherwise, `false`.
    public func validate(toPattern pattern: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: self)
    }
    /// Check if the string is a valid email address.
    ///
    /// - Returns: `true` if the string is a valid email address; otherwise, `false`.
    public func isValidEmail() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return validate(toPattern: emailPattern)
    }
    /// Check if the string is a valid Egypt phone number.
    ///
    /// - Returns: `true` if the string is a valid Egypt phone number; otherwise, `false`.
    public func isValidEgyptPhoneNumber() -> Bool {
        let pattern = "(01)[0-9]{9}"
        return validate(toPattern: pattern)
    }
}
