//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 25/10/2023.
//

import UIKit

extension UIImageView {
    @discardableResult
    public func makeCircle(withWidth width: CGFloat, lineWidth: CGFloat = 1.5, borderColor: UIColor = .blue) -> UIImageView {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: width).isActive = true
        layer.cornerRadius = width / 2
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = lineWidth
        return self
    }
}
