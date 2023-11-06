//
//  LoginAlertViewController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 29/10/2023.
//

import UIKit

class LoginAlertViewController: SheetViewController {
    // MARK: - Views
    //
    let loginAlertView = LoginAlertView()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.LoginAlert.header
        addChild(loginAlertView)
        configureView()
    }
}
//
extension LoginAlertViewController {
    private func configureView() {
        loginAlertView.configure(with: .init(buttonAction: {
            self.loginButtonAction()
        }))
    }
}
//
extension LoginAlertViewController {
    func loginButtonAction() {
        dismiss(animated: true, completion: {
            UIApplication
                .shared
                .mainWindow?
                .rootViewController = Coordinator.shared.login()
        })
    }
}
