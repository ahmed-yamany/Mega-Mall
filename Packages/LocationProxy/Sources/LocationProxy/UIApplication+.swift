//
//  UIApplication+.swift
//  
//
//  Created by Ahmed Yamany on 01/11/2023.
//

import UIKit

public extension UIViewController {
    // This function recursively searches for the topmost view controller.
    func topMostViewController() -> UIViewController {
        // If the current view controller has no presented view controller, it is the topmost one.
        if self.presentedViewController == nil {
            return self
        }
        // If the presented view controller is a UINavigationController, check for its visible view controller.
        if let navigation = self.presentedViewController as? UINavigationController,
           let visibleViewController = navigation.visibleViewController {
            return visibleViewController.topMostViewController()
        }
        // If the presented view controller is a UITabBarController, check its selected view controller.
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            // If no selected view controller is available, check the tab bar controller itself.
            return tab.topMostViewController()
        }
        // If none of the above conditions are met,
        // raise a fatal error with a message indicating that the presentedViewController is not found.
        guard let presentedViewController else {
            fatalError("Couldn't find presentedViewController for \(self.self) ")
        }
        // If none of the conditions above match, continue the search in the presented view controller.
        return presentedViewController.topMostViewController()
    }
}
///
@available(iOS 13.0, *)
public extension UIApplication {
    var mainWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}
///
public extension UIApplication {
    // This function returns the topmost view controller by starting from the root view controller of the key window.
    @available(iOS 13.0, *)
    func topMostViewController() -> UIViewController? {
        return self.mainWindow?.rootViewController?.topMostViewController()
    }
}
