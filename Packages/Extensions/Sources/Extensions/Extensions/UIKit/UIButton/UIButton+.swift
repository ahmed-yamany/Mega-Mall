//
//  UIButton+.swift
//
//  Created by Ahmed Yamany on 22/10/2023.
//

import UIKit
// swiftlint: disable all
extension UIButton {
    /**
     Set the background color for a specific control state.

     - Parameters:
       - color: The background color to be set.
       - forState: The control state for which the background color should be applied.

     This extension method allows you to easily set the background color of a UIButton for a specific control state.
     It automatically creates a solid color image with the provided color and sets it as the button's background image.
     To maintain the corner radius of the button when setting the background color, `clipsToBounds` is set to `true`.

     - Note: To create a `UIColor` object, you can use the `UIColor` initializer, such as `UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)`.
     - SeeAlso: `UIColor`, `setBackgroundImage(_:for:)`

     Example usage:

     ```swift
     let myButton = UIButton()
     myButton.setBackgroundColor(color: UIColor.blue, forState: .normal)
     ```

     - Warning: This method will override any existing background image for the specified control state.
     */
    public func setBackgroundColor(color: UIColor, forState state: UIControl.State) {
        self.clipsToBounds = true  // Add this to maintain corner radius
        let colorImage = UIImage(color: color)
        self.setBackgroundImage(colorImage, for: state)
    }
}
// swiftlint: enable all
