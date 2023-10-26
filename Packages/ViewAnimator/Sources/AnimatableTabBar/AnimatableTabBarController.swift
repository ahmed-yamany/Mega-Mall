//
//  AnimatableTabBarController.swift
//
//  Created by Ahmed Yamany on 25/10/2023.
//
import UIKit
import Extensions

/// A delegate protocol for handling animations on a `UITabBarController`.
public protocol AnimatableTabBarControllerDelegate {
    /// Animate a view associated with a tab bar item.
    ///
    /// - Parameters:
    ///   - view: The view to be animated.
    ///   - item: The `UITabBarItem` associated with the view.
    func animate(_ view: UIView, at item: UITabBarItem)
}

@available(iOS 13.0, *)
/// A subclass of `UITabBarController` that supports tab bar item animations.
open class AnimatableTabBarController: UITabBarController, AnimatableTabBarControllerDelegate {
    /// The configurations for the animatable tab bar.
    public var configurations: AnimatableTabBarConfigurations = .init()
    /// The currently selected tab bar item, used to determine when to trigger animations.
    private lazy var selectedItem: UITabBarItem? = tabBar.selectedItem
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard configurations.animatable else { return }
        if configurations.animatenWhileSelected {
            animate(tabBar: tabBar, at: item)
        } else if selectedItem != item {
            animate(tabBar: tabBar, at: item)
            selectedItem = item
        }
    }
    /// Animate a specific tab bar item.
    ///
    /// - Parameters:
    ///   - tabBar: The `UITabBar` instance.
    ///   - item: The `UITabBarItem` to be animated.
    private func animate(tabBar: UITabBar, at item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else {
            debugPrint("Failed to get item's index from UITabBar when animating")
            return
        }
        let itemSubviews: [UIView] = tabBar.subviews[index+1].subviews
        let animationScope = configurations.animationScope
        if animationScope == .image, let imageView = itemSubviews.first {
            animate(imageView, at: item)
        } else if animationScope == .title {
            let titleView = itemSubviews[1]
            animate(titleView, at: item)
        } else {
            for subview in itemSubviews {
                animate(subview, at: item)
            }
        }
    }
    /// Animate a view associated with a tab bar item.
   ///
   /// - Parameters:
   ///   - view: The view to be animated.
   ///   - item: The `UITabBarItem` associated with the view.
    open func animate(_ view: UIView, at item: UITabBarItem) {
        view.animate(animations: [AnimationType.random()])
    }
    // swiftlint: disable all
    open func imageView(of item: UITabBarItem) -> UIImageView? {
        guard let index = self.tabBar.items?.firstIndex(of: item) else {
            debugPrint("Failed to get item's index from UITabBar when animating")
            return nil
        }
        let itemSubviews: [UIView] = tabBar.subviews[index+1].subviews
        return itemSubviews.first as? UIImageView
    }
    // swiftlint: enable all
}
