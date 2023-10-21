// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Onboarding {
    /// Forgot Password
    internal static let forgotpassword = L10n.tr("Localizable", "onboarding.forgotpassword", fallback: "Forgot Password")
    /// Localizable.strings
    ///   Mega Mall
    /// 
    ///   Created by Ahmed Yamany on 21/10/2023.
    internal static let signin = L10n.tr("Localizable", "onboarding.signin", fallback: "Sign In")
    /// Sign Up
    internal static let signup = L10n.tr("Localizable", "onboarding.signup", fallback: "Sign Up")
    internal enum Login {
      internal enum Decription {
        /// Please enter data to log in
        internal static let subtitle = L10n.tr("Localizable", "onboarding.login.decription.subtitle", fallback: "Please enter data to log in")
        /// Welcome back to Mega Mall
        internal static let title = L10n.tr("Localizable", "onboarding.login.decription.title", fallback: "Welcome back to Mega Mall")
      }
      internal enum Email {
        /// Email/Phone
        internal static let label = L10n.tr("Localizable", "onboarding.login.email.label", fallback: "Email/Phone")
        /// Enter your Email Address/ Telephone Number
        internal static let placeholder = L10n.tr("Localizable", "onboarding.login.email.placeholder", fallback: "Enter your Email Address/ Telephone Number")
      }
      internal enum Password {
        /// Password
        internal static let label = L10n.tr("Localizable", "onboarding.login.password.label", fallback: "Password")
        /// Enter Account Password
        internal static let placeholder = L10n.tr("Localizable", "onboarding.login.password.placeholder", fallback: "Enter Account Password")
      }
    }
    internal enum Register {
      internal enum Email {
        internal enum Decription {
          /// Enter Email/Number. Mobile to register
          internal static let subtitle = L10n.tr("Localizable", "onboarding.register.email.decription.subtitle", fallback: "Enter Email/Number. Mobile to register")
          /// Register Account
          internal static let title = L10n.tr("Localizable", "onboarding.register.email.decription.title", fallback: "Register Account")
        }
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
