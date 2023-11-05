//
//  WishlistButton.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 05/11/2023.
//

import UIKit
import MakeConstraints
import Extensions

class WishlistButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    private func configure() {
        layerCornerRadius = 10
        //
        setBackgroundColor(color: .systemRed, forState: .normal)
        setBackgroundColor(color: .megaSecondaryHalfGray, forState: .disabled)
        //
        setTitleColor(.megaPrimaryPureWhite, for: .normal)
        setTitleColor(.megaPrimaryPureWhite, for: .disabled)
        tintColor = .megaPrimaryPureWhite
        //
        heightConstraints(52)
        //
        configuration = nil
        titleLabel?.font = .medium
        setImage(.tabbarWishlist, for: .normal)
        //
        semanticContentAttribute = .forceRightToLeft
    }
}
