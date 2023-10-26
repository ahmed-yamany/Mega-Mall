//
//  UINavigationItem+.swift
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit

public extension UINavigationItem {
    /// Sets a custom title view with
    ///
    /// - Parameters:
    ///   - text: The text to be displayed as the title.
    ///   - color: The color of the title text. If not provided, the default text color is used.
    ///   - font: The font of the title text
    func addTitleLabel(with text: String,
                       color: UIColor = .blue,
                       font: UIFont = .systemFont(ofSize: UIFont.labelFontSize, weight: .bold)) {
        // Create a UILabel instance to display the title
        let label = UILabel()
        label.text = text
        // Set the font for the title text
        label.font = font
        // Set the color of the title text if provided, otherwise use the default text color
        label.textColor = color
        // Set the created label as the title view of the navigation item
        titleView = label
    }
}
