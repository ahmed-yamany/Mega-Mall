//
//  ResetPasswordViewModelType.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 24/10/2023.
//

import Foundation
import Combine
/// ResetPassword Input & Output
///
typealias ResetPasswordViewModelType = ResetPasswordViewModelInput & ResetPasswordViewModelOutput

/// ResetPassword ViewModel Input
///
protocol ResetPasswordViewModelInput {
    var emailViewModel: OnboardingTextField.ViewModel { get }
}

/// ResetPassword ViewModel Output
///
protocol ResetPasswordViewModelOutput {
    var enableButton: AnyPublisher<Bool, Never> { get }
    var cancellableSet: Set<AnyCancellable> { get set }
}
