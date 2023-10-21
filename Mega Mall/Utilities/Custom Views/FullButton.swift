//
//  PrimaryButton.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 21/10/2023.
//

import UIKit
import MakeConstraints
import Extensions

class FullButton: UIButton {
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
        setBackgroundColor(color: .megaPrimaryBlueOcean, forState: .normal)
        setBackgroundColor(color: .megaSecondaryHalfGray, forState: .disabled)
        setTitleColor(.megaPrimaryPureWhite, for: .normal)
        setTitleColor(.megaPrimaryPureWhite, for: .disabled)
        heightConstraints(52)
        configuration = nil
        titleLabel?.font = .medium
    }
}
