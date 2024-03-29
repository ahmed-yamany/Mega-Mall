//
//  LoginManager.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 29/10/2023.
//

import UIKit
import Extensions

class LoginManager {
    static let shared = LoginManager()
    private init() {}
    func checkLogin(loginHandler: @escaping () -> Void = {},
                    notLoginHandeler: @escaping () -> Void = {}) {
        guard !TabBarViewModel.shared.isLogin else {
            loginHandler()
            return
        }
        //
        let viewController = LoginAlertViewController()
        viewController.presentSheet(completion: notLoginHandeler)
    }
}
