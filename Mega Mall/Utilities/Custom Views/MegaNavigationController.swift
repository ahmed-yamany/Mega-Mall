//
//  NavigationController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit
import MakeConstraints

class MegaNavigationController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureViews()
    }
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        viewController.navigationItem.backButtonTitle = ""
    }
}

extension MegaNavigationController {
    private func configureViews() {
        configureNavigationBar()
    }
    private func configureNavigationBar() {
        configureNavigationBarShadow()
        configureNavigationBarBackButton()
    }
    private func configureNavigationBarShadow() {
        navigationBar.layer.shadowColor = UIColor.megaSecondaryDarkGray.cgColor
        let shadowSize: CGFloat = 0.5
        let contactRect = CGRect(x: -shadowSize, y: navigationBar.frame.height - (shadowSize * 0.4),
                                 width: view.frame.width + shadowSize * 2, height: shadowSize)
        navigationBar.layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        navigationBar.layer.shadowOpacity = 0.4
        navigationBar.layer.shadowRadius = 1
    }
    private func configureNavigationBarBackButton() {
        navigationBar.tintColor = .megaPrimaryNavyBlack
        navigationBar.backIndicatorImage = .megaBack
        navigationBar.backIndicatorTransitionMaskImage = .megaBack
    }
}
