//
//  H1Label.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 21/10/2023.
//

import UIKit

class H1Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        update()
    }
    private func update() {
        font = .h1
        numberOfLines = 0
    }
}
