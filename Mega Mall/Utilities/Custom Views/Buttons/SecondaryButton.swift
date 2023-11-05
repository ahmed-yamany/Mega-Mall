//
//  SecondaryButton.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 04/11/2023.
//

import UIKit
import MakeConstraints
import Extensions

class SecondaryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    ///
    private func configure() {
        layerCornerRadius = 10
        layerBorderWidth = 1
        layerBorderColor = .megaPrimaryNavyBlack
        //
        setBackgroundColor(color: .clear, forState: .normal)
        setBackgroundColor(color: .megaSecondaryHalfGray, forState: .disabled)
        //
        setTitleColor(.megaPrimaryNavyBlack, for: .normal)
        setTitleColor(.megaPrimaryNavyBlack, for: .disabled)
        //
        heightConstraints(52)
        //
        configuration = nil
        titleLabel?.font = .medium
    }
}
