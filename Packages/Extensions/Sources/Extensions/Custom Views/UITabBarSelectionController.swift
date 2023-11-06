//
//  TabBarSelectionController.swift
//
//  Created by Ahmed Yamany on 25/10/2023.
//
import UIKit

// swiftlint: disable all
/**
 This class allows you to customize the behavior when a tab is selected and provides methods to access and modify subviews associated with tab bar items.

 You can subclass `UITabBarSelectionController` and override its methods to implement custom behavior when a tab is selected.
*/
// swiftlint: disable all
@available(iOS 13.0, *)
open class UITabBarSelectionController: UITabBarController {
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else {
            debugPrint("Failed to get item's index")
            return
        }
        //
        let itemView: UIView = tabBar.subviews[index+1]
        let itemSubviews: [UIView] = itemView.subviews
        // item view
        tabBarDidSelect(tabBar, item: item, view: itemView)
        // item image
        if let imageView = itemSubviews.first as? UIImageView {
            tabBarDidSelect(tabBar, item: item, imageView: imageView)
        }
        // item label
        if let titleLabel = itemSubviews[1] as? UILabel {
            tabBarDidSelect(tabBar, item: item, titleLabel: titleLabel)
        }
    }
    open func imageView(of item: UITabBarItem) -> UIImageView? {
        guard let index = self.tabBar.items?.firstIndex(of: item) else {
            debugPrint("Failed to get item's index from UITabBar when animating")
            return nil
        }
        let itemSubviews: [UIView] = tabBar.subviews[index+1].subviews
        return itemSubviews.first as? UIImageView
    }
    // MARK: - Customization Methods
    
    /**
     Called when a tab is selected and provides the associated view.
     
     - Parameters:
       - tabBar: The tab bar that received the selection event.
       - item: The selected tab bar item.
       - view: The view associated with the selected tab.
     */
    open func tabBarDidSelect(_ tabBar: UITabBar, item: UITabBarItem, view: UIView) {}
    
    /**
     Called when a tab is selected and provides the associated `UIImageView`.
     
     - Parameters:
       - tabBar: The tab bar that received the selection event.
       - item: The selected tab bar item.
       - imageView: The `UIImageView` associated with the selected tab.
     */
    open func tabBarDidSelect(_ tabBar: UITabBar, item: UITabBarItem, imageView: UIImageView) {}
    
    /**
     Called when a tab is selected and provides the associated `UILabel`.
     
     - Parameters:
       - tabBar: The tab bar that received the selection event.
       - item: The selected tab bar item.
       - titleLabel: The `UILabel` associated with the selected tab.
     */
    open func tabBarDidSelect(_ tabBar: UITabBar, item: UITabBarItem, titleLabel: UILabel) {}
    // MARK: - Helper Methods
      
      private func tabView(forItemAtIndex index: Int) -> UIView {
          return tabBar.subviews[index + 1]
      }
}
