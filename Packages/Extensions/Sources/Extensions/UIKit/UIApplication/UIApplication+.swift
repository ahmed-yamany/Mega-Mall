//
//  UIApplication.swift
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit

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
