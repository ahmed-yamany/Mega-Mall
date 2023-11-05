//
//  LabelButton.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 21/10/2023.
//

import UIKit

class LabelButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    private func configure() {
        configuration = nil
        setTitleColor(.megaPrimaryBlueOcean, for: .normal)
        titleLabel?.font = .medium
    }
}
