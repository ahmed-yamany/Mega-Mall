//
//  Coordinator.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 06/11/2023.
//

import UIKit
import Factory

final class Coordinator: SharedContainer {
    static var shared: Coordinator = Coordinator()
    var manager: ContainerManager = .init()
    ///
    private init() {}
}

// MARK: - TabBar
extension Coordinator {
    var tabbar: ParameterFactory<TabBarViewModel, UITabBarController> {
        self { TabBarViewController(viewModel: $0) }
    }
}
// MARK: - Onboarding
extension Coordinator {
    var login: Factory<UINavigationController> {
        self { MegaNavigationController(rootViewController: LoginViewController()) }
            .shared
    }
    //
    var verification: ParameterFactory<VerificationViewModel, UIViewController> {
        self { VerificationViewController(viewModel: $0) }
            .shared
    }
    //
    var forgotPassword: Factory<UIViewController> {
        self { ResetPasswordViewController() }
            .shared
    }
    //
    var updatePassword: Factory<UIViewController> {
        self { UpdatePasswordViewController() }
    }
    //
    var register: Factory<UIViewController> {
        self { RegisterViewController() }
            .shared
    }
    //
    var profileUpdate: Factory<UIViewController> {
        self { ProfileUpdateViewController() }
    }
}
