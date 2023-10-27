// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum App {
    /// See All
    internal static let seeAll = L10n.tr("Localizable", "app.seeAll", fallback: "See All")
    internal enum Search {
      internal enum TextField {
        /// Search Product Name
        internal static let placeholder = L10n.tr("Localizable", "app.search.textField.placeholder", fallback: "Search Product Name")
      }
    }
  }
  internal enum Onboarding {
    /// Change
    internal static let change = L10n.tr("Localizable", "onboarding.change", fallback: "Change")
    /// Confirmation
    internal static let confirmation = L10n.tr("Localizable", "onboarding.confirmation", fallback: "Confirmation")
    /// Continue
    internal static let `continue` = L10n.tr("Localizable", "onboarding.continue", fallback: "Continue")
    /// Forgot Password
    internal static let forgotpassword = L10n.tr("Localizable", "onboarding.forgotpassword", fallback: "Forgot Password")
    /// Reset
    internal static let reset = L10n.tr("Localizable", "onboarding.reset", fallback: "Reset")
    /// Save Update
    internal static let saveUpdates = L10n.tr("Localizable", "onboarding.saveUpdates", fallback: "Save Update")
    /// Localizable.strings
    ///   Mega Mall
    /// 
    ///   Created by Ahmed Yamany on 21/10/2023.
    internal static let signin = L10n.tr("Localizable", "onboarding.signin", fallback: "Sign In")
    /// Sign Up
    internal static let signup = L10n.tr("Localizable", "onboarding.signup", fallback: "Sign Up")
    internal enum ForgotPassword {
      internal enum Decription {
        /// Enter Email/Number to reset your password
        internal static let subtitle = L10n.tr("Localizable", "onboarding.forgotPassword.decription.subtitle", fallback: "Enter Email/Number to reset your password")
        /// Reset Password
        internal static let title = L10n.tr("Localizable", "onboarding.forgotPassword.decription.title", fallback: "Reset Password")
      }
      internal enum Email {
        /// Email/Phone
        internal static let label = L10n.tr("Localizable", "onboarding.forgotPassword.email.label", fallback: "Email/Phone")
        /// Enter Email/Number to reset password
        internal static let placeholder = L10n.tr("Localizable", "onboarding.forgotPassword.email.placeholder", fallback: "Enter Email/Number to reset password")
      }
    }
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
        /// Email/Phone
        internal static let label = L10n.tr("Localizable", "onboarding.register.email.label", fallback: "Email/Phone")
        /// Enter your Email Address/ Telephone Number
        internal static let placeholder = L10n.tr("Localizable", "onboarding.register.email.placeholder", fallback: "Enter your Email Address/ Telephone Number")
        internal enum Decription {
          /// Enter Email/Number to register
          internal static let subtitle = L10n.tr("Localizable", "onboarding.register.email.decription.subtitle", fallback: "Enter Email/Number to register")
          /// Register Account
          internal static let title = L10n.tr("Localizable", "onboarding.register.email.decription.title", fallback: "Register Account")
        }
      }
    }
    internal enum UpdatePassword {
      internal enum ConfirmPassword {
        /// Confirm New Password
        internal static let label = L10n.tr("Localizable", "onboarding.updatePassword.confirmPassword.label", fallback: "Confirm New Password")
        /// Rahasia12345
        internal static let placeholder = L10n.tr("Localizable", "onboarding.updatePassword.confirmPassword.placeholder", fallback: "Rahasia12345")
      }
      internal enum Decription {
        /// Complete the following final data to enter the Mega Mall application
        internal static let subtitle = L10n.tr("Localizable", "onboarding.updatePassword.decription.subtitle", fallback: "Complete the following final data to enter the Mega Mall application")
        /// Update Password
        internal static let title = L10n.tr("Localizable", "onboarding.updatePassword.decription.title", fallback: "Update Password")
      }
      internal enum Insight {
        /// Password must be 6 characters or more
        internal static let label = L10n.tr("Localizable", "onboarding.updatePassword.insight.label", fallback: "Password must be 6 characters or more")
      }
      internal enum Password {
        /// New Password
        internal static let label = L10n.tr("Localizable", "onboarding.updatePassword.password.label", fallback: "New Password")
        /// Rahasia12345
        internal static let placeholder = L10n.tr("Localizable", "onboarding.updatePassword.password.placeholder", fallback: "Rahasia12345")
      }
    }
    internal enum UpdateProfile {
      internal enum Decription {
        /// Complete the following final data to enter the Mega Mall application
        internal static let subtitle = L10n.tr("Localizable", "onboarding.updateProfile.decription.subtitle", fallback: "Complete the following final data to enter the Mega Mall application")
        /// Profile & Password
        internal static let title = L10n.tr("Localizable", "onboarding.updateProfile.decription.title", fallback: "Profile & Password")
      }
      internal enum FullName {
        /// Full Name
        internal static let label = L10n.tr("Localizable", "onboarding.updateProfile.fullName.label", fallback: "Full Name")
        /// Matias Duarte
        internal static let placeholder = L10n.tr("Localizable", "onboarding.updateProfile.fullName.placeholder", fallback: "Matias Duarte")
      }
      internal enum Insight {
        /// Password must be 6 characters or more
        internal static let label = L10n.tr("Localizable", "onboarding.updateProfile.insight.label", fallback: "Password must be 6 characters or more")
      }
      internal enum Password {
        /// Password
        internal static let label = L10n.tr("Localizable", "onboarding.updateProfile.password.label", fallback: "Password")
        /// Rahasia12345
        internal static let placeholder = L10n.tr("Localizable", "onboarding.updateProfile.password.placeholder", fallback: "Rahasia12345")
      }
      internal enum ReferalCode {
        /// Referal Code (Optional)
        internal static let label = L10n.tr("Localizable", "onboarding.updateProfile.referalCode.label", fallback: "Referal Code (Optional)")
        /// Input your code
        internal static let placeholder = L10n.tr("Localizable", "onboarding.updateProfile.referalCode.placeholder", fallback: "Input your code")
      }
    }
    internal enum Verification {
      internal enum Decription {
        /// We have sent a verification code to
        internal static let subtitle = L10n.tr("Localizable", "onboarding.verification.decription.subtitle", fallback: "We have sent a verification code to")
        /// Verification
        internal static let title = L10n.tr("Localizable", "onboarding.verification.decription.title", fallback: "Verification")
      }
      internal enum Resend {
        /// Re-send Code
        internal static let button = L10n.tr("Localizable", "onboarding.verification.resend.button", fallback: "Re-send Code")
        /// Verification Code
        internal static let label = L10n.tr("Localizable", "onboarding.verification.resend.label", fallback: "Verification Code")
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
