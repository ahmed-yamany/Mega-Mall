//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 21/10/2023.
//

import UIKit
import MakeConstraints

extension UITextField {
    /// SwifterSwift: Add padding to the left of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    public func addPaddingLeft(_ padding: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftViewMode = .always
    }
    /// SwifterSwift: Add padding to the right of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the right of the textfield rect.
    public func addPaddingRight(_ padding: CGFloat) {
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightViewMode = .always
    }
}

extension UITextField {
    /// Adds an image to the right side of the UITextField.
    ///
    /// - Parameters:
    ///   - image: The image to be displayed.
    ///   - tintColor: The color to apply to the image.
    public func addPaddingRightIcon(_ image: UIImage, padding: CGFloat, tintColor: UIColor = .blue) {
        let view = UIView()
        let imageView = UIImageView(image: image)
        imageView.tintColor = tintColor
        view.widthConstraints(imageView.bounds.width + padding)
        view.heightConstraints(imageView.bounds.height)
        view.addSubview(imageView)
        imageView.centerYInSuperview()
        imageView.makeConstraints(leadingAnchor: view.leadingAnchor)
        rightView = view
        rightViewMode = .always
    }
    /// Adds an image to the left side of the UITextField.
    ///
    /// - Parameters:
    ///   - image: The image to be displayed.
    ///   - tintColor: The color to apply to the image.
    public func addPaddingLeftIcon(_ image: UIImage?, padding: CGFloat, tintColor: UIColor) {
        let view = UIView()
        let imageView = UIImageView(image: image)
        imageView.tintColor = tintColor
        view.widthConstraints(imageView.bounds.width + padding)
        view.heightConstraints(imageView.bounds.height)
        view.addSubview(imageView)
        imageView.centerYInSuperview()
        imageView.makeConstraints(trailingAnchor: view.trailingAnchor)
        leftView = view
        leftViewMode = .always
    }
}
