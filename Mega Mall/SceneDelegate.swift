//
//  SceneDelegate.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 21/10/2023.
//

import UIKit
import IQKeyboardManagerSwift
import Extensions

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    @UserDefault<Bool>(key: \.login) var login
    //
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        //
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        TabBarViewModel.shared.isLogin = login ?? false
        window.rootViewController = TabBarViewController()
        window.makeKeyAndVisible()
        self.window = window
        //
        IQKeyboardManager.shared.enable = true
    }
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
