//
//  RegisterViewModelType.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 24/10/2023.
//

import Foundation
import Combine
/// ResetPassword Input & Output
///
typealias RegisterViewModelType = RegisterViewModelInput & RegisterViewModelOutput

/// ResetPassword ViewModel Input
///
protocol RegisterViewModelInput {
    var emailViewModel: OnboardingTextField.ViewModel { get }
}

/// ResetPassword ViewModel Output
///
protocol RegisterViewModelOutput {
    var enableButton: AnyPublisher<Bool, Never> { get }
    var cancellableSet: Set<AnyCancellable> { get set }
}
